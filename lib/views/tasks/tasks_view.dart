import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../utils/theme.dart';
import '../../widgets/common_widgets.dart';
import '../../providers/providers.dart';
import '../../models/database.dart';
import 'package:drift/drift.dart' hide Column;

class TasksView extends ConsumerStatefulWidget {
  const TasksView({super.key});

  @override
  ConsumerState<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends ConsumerState<TasksView> {
  TaskStatus? _filterStatus;
  TaskPriority? _filterPriority;

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          var filtered = tasks.toList();

          if (_filterStatus != null) {
            filtered =
                filtered.where((t) => t.taskStatus == _filterStatus).toList();
          }
          if (_filterPriority != null) {
            filtered =
                filtered.where((t) => t.priority == _filterPriority).toList();
          }

          // Sort by priority then due date
          filtered.sort((a, b) {
            final priorityCompare =
                b.priority.index.compareTo(a.priority.index);
            if (priorityCompare != 0) return priorityCompare;
            if (a.dueDate == null) return 1;
            if (b.dueDate == null) return -1;
            return a.dueDate!.compareTo(b.dueDate!);
          });

          if (filtered.isEmpty) {
            return EmptyStateView(
              icon: Icons.task_alt,
              title: 'No tasks',
              subtitle: 'Add tasks to manage your ranch work',
              buttonText: 'Add Task',
              onButtonTap: () => _showAddTaskDialog(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.standardPadding),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final task = filtered[index];
              return _TaskCard(
                task: task,
                onStatusChanged: (status) => _updateTaskStatus(task, status),
                onDelete: () => _deleteTask(task),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppTheme.standardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _filterStatus = null;
                      _filterPriority = null;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Status', style: TextStyle(fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 8,
              children: TaskStatus.values.map((status) {
                return ChoiceChip(
                  label: Text(status.label),
                  selected: _filterStatus == status,
                  onSelected: (selected) {
                    setState(() => _filterStatus = selected ? status : null);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Priority', style: TextStyle(fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 8,
              children: TaskPriority.values.map((priority) {
                return ChoiceChip(
                  label: Text(priority.label),
                  selected: _filterPriority == priority,
                  onSelected: (selected) {
                    setState(() => _filterPriority = selected ? priority : null);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final assigneeController = TextEditingController();
    DateTime? dueDate;
    TaskPriority priority = TaskPriority.medium;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title *'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: assigneeController,
                  decoration: const InputDecoration(labelText: 'Assignee'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Due Date: '),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setDialogState(() => dueDate = date);
                        }
                      },
                      child: Text(
                        dueDate != null
                            ? '${dueDate!.month}/${dueDate!.day}/${dueDate!.year}'
                            : 'Select',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<TaskPriority>(
                  value: priority,
                  decoration: const InputDecoration(labelText: 'Priority'),
                  items: TaskPriority.values
                      .map((p) => DropdownMenuItem(
                            value: p,
                            child: Text(p.label),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => priority = val);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty) return;
                await _addTask(
                  title: titleController.text,
                  description: descriptionController.text,
                  assignee: assigneeController.text.isEmpty
                      ? null
                      : assigneeController.text,
                  dueDate: dueDate,
                  priority: priority,
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addTask({
    required String title,
    String description = '',
    String? assignee,
    DateTime? dueDate,
    required TaskPriority priority,
  }) async {
    final db = ref.read(databaseProvider);
    final now = DateTime.now();

    await db.into(db.tasks).insert(TasksCompanion.insert(
          id: const Uuid().v4(),
          title: title,
          description: Value(description),
          assignee: Value(assignee),
          dueDate: Value(dueDate),
          priority: priority,
          taskStatus: TaskStatus.pending,
          createdAt: now,
          updatedAt: now,
        ));
  }

  Future<void> _updateTaskStatus(Task task, TaskStatus status) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(
        taskStatus: Value(status),
        completedAt:
            Value(status == TaskStatus.completed ? DateTime.now() : null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _deleteTask(Task task) async {
    final db = ref.read(databaseProvider);
    await (db.delete(db.tasks)..where((t) => t.id.equals(task.id))).go();
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final ValueChanged<TaskStatus> onStatusChanged;
  final VoidCallback onDelete;

  const _TaskCard({
    required this.task,
    required this.onStatusChanged,
    required this.onDelete,
  });

  Color get _priorityColor {
    switch (task.priority) {
      case TaskPriority.low:
        return Colors.grey;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.high:
        return Colors.orange;
      case TaskPriority.urgent:
        return Colors.red;
    }
  }

  bool get _isOverdue {
    if (task.dueDate == null) return false;
    return task.dueDate!.isBefore(DateTime.now()) &&
        task.taskStatus != TaskStatus.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Checkbox(
                value: task.taskStatus == TaskStatus.completed,
                activeColor: AppTheme.earthGreen,
                onChanged: (checked) {
                  onStatusChanged(
                    checked == true
                        ? TaskStatus.completed
                        : TaskStatus.pending,
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: task.taskStatus == TaskStatus.completed
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    if (task.description.isNotEmpty)
                      Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (task.dueDate != null)
                          Text(
                            '${task.dueDate!.month}/${task.dueDate!.day}',
                            style: TextStyle(
                              fontSize: 12,
                              color: _isOverdue ? Colors.red : Colors.grey[600],
                            ),
                          ),
                        if (task.assignee != null) ...[
                          const SizedBox(width: 8),
                          Icon(Icons.person, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 2),
                          Text(
                            task.assignee!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  task.priority.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: _priorityColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
