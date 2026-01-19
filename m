Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6912F4A14
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856398; cv=none; b=CqIF2lRTzGujKCSjT2vJutgYxvKJfqEZRCVAIjsUyfw6piPjWpy5naWnJx3Izs829Iwa8lTWa+kPqJjSMQQaFjLuhgZK5yOwbIVkWsysUTNYQsdelP++9pYkj+kbyvVseGiiU5fUYj049hUbM9uuFeB1Wt2GAghlnQqhz+aXv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856398; c=relaxed/simple;
	bh=Ef3V9U3KkJbH7Tsrqg0l+WydrWklOLdphNqtVGBOZtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvCaC9KR7f1YbWxNVTqTXZksjzTLT3fW+yb12XEOOGTH1m8awJNwWpI4XpIsfpfi0+xfTsYG8fDOpFDasEYn9NCYHU7gvjtdZciuF6Hag3Ai/lwlQeX9aAdksO0fzaLmy1BMsMYzweBP2+i6Qtl1Z9qY9Ay6MMq5+Ct0A7kE6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9T72m+q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9T72m+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yj89ReA7SC9wjYbuj/WC8bJ+s1gi/80kfHSLMsU4EBw=;
	b=L9T72m+qx57nmfzL4rvumVRFn10xEPQw6sce50XDccorpC5saIgEn4fwHTCxdwRWzGK27b
	o3H7I8t4tbIfFQ7xsWBua4aT1K2v+oQ2qBNW/lXIELoZqb09pjAFlBMYZeZgF3mdgNAbd0
	zv1GMZoaMzM2AkSZdDxYbyzxvOOpN1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-fcciGlGNOFKUoa7JXaWnJw-1; Mon,
 19 Jan 2026 15:59:51 -0500
X-MC-Unique: fcciGlGNOFKUoa7JXaWnJw-1
X-Mimecast-MFC-AGG-ID: fcciGlGNOFKUoa7JXaWnJw_1768856390
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B40818005AF;
	Mon, 19 Jan 2026 20:59:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D032F19560AB;
	Mon, 19 Jan 2026 20:59:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 03/26] rv/rvgen: replace % string formatting with f-strings
Date: Mon, 19 Jan 2026 17:45:39 -0300
Message-ID: <20260119205601.105821-4-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace all instances of percent-style string formatting with
f-strings across the rvgen codebase. This modernizes the string
formatting to use Python 3.6+ features, providing clearer and more
maintainable code while improving runtime performance.

The conversion handles all formatting cases including simple variable
substitution, multi-variable formatting, and complex format specifiers.
Dynamic width formatting is converted from "%*s" to "{var:>{width}}"
using proper alignment syntax. Template strings for generated C code
properly escape braces using double-brace syntax to produce literal
braces in the output.

F-strings provide approximately 2x performance improvement over percent
formatting and are the recommended approach in modern Python.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/__main__.py        |  6 +--
 tools/verification/rvgen/rvgen/automata.py  |  6 +--
 tools/verification/rvgen/rvgen/dot2c.py     | 40 +++++++-------
 tools/verification/rvgen/rvgen/dot2k.py     | 26 ++++-----
 tools/verification/rvgen/rvgen/generator.py | 59 ++++++++++-----------
 tools/verification/rvgen/rvgen/ltl2k.py     | 30 +++++------
 6 files changed, 82 insertions(+), 85 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 768b11a1e978b..eeeccf81d4b90 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -40,7 +40,7 @@ if __name__ == '__main__':
     params = parser.parse_args()
 
     if params.subcmd == "monitor":
-        print("Opening and parsing the specification file %s" % params.spec)
+        print(f"Opening and parsing the specification file {params.spec}")
         if params.monitor_class == "da":
             monitor = dot2k(params.spec, params.monitor_type, vars(params))
         elif params.monitor_class == "ltl":
@@ -51,11 +51,11 @@ if __name__ == '__main__':
     else:
         monitor = Container(vars(params))
 
-    print("Writing the monitor into the directory %s" % monitor.name)
+    print(f"Writing the monitor into the directory {monitor.name}")
     monitor.print_files()
     print("Almost done, checklist")
     if params.subcmd == "monitor":
-        print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
+        print(f"  - Edit the {monitor.name}/{monitor.name}.c to add the instrumentation")
         print(monitor.fill_tracepoint_tooltip())
     print(monitor.fill_makefile_tooltip())
     print(monitor.fill_kconfig_tooltip())
diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 8d88c3b65d00d..3e24313a2eaec 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -39,11 +39,11 @@ class Automata:
         basename = ntpath.basename(self.__dot_path)
         if not basename.endswith(".dot") and not basename.endswith(".gv"):
             print("not a dot file")
-            raise AutomataError("not a dot file: %s" % self.__dot_path)
+            raise AutomataError(f"not a dot file: {self.__dot_path}")
 
         model_name = ntpath.splitext(basename)[0]
         if model_name.__len__() == 0:
-            raise AutomataError("not a dot file: %s" % self.__dot_path)
+            raise AutomataError(f"not a dot file: {self.__dot_path}")
 
         return model_name
 
@@ -62,7 +62,7 @@ class Automata:
         line = dot_lines[cursor].split()
 
         if (line[0] != "digraph") and (line[1] != "state_automaton"):
-            raise AutomataError("Not a valid .dot format: %s" % self.__dot_path)
+            raise AutomataError(f"Not a valid .dot format: {self.__dot_path}")
         else:
             cursor += 1
         return dot_lines
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 1a1770e7f20c0..78959d345c26e 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -37,11 +37,11 @@ class Dot2c(Automata):
 
     def __get_enum_states_content(self):
         buff = []
-        buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
+        buff.append(f"\t{self.initial_state}{self.enum_suffix} = 0,")
         for state in self.states:
             if state != self.initial_state:
-                buff.append("\t%s%s," % (state, self.enum_suffix))
-        buff.append("\tstate_max%s" % (self.enum_suffix))
+                buff.append(f"\t{state}{self.enum_suffix},")
+        buff.append(f"\tstate_max{self.enum_suffix}")
 
         return buff
 
@@ -51,7 +51,7 @@ class Dot2c(Automata):
 
     def format_states_enum(self):
         buff = []
-        buff.append("enum %s {" % self.enum_states_def)
+        buff.append(f"enum {self.enum_states_def} {{")
         buff.append(self.get_enum_states_string())
         buff.append("};\n")
 
@@ -62,12 +62,12 @@ class Dot2c(Automata):
         first = True
         for event in self.events:
             if first:
-                buff.append("\t%s%s = 0," % (event, self.enum_suffix))
+                buff.append(f"\t{event}{self.enum_suffix} = 0,")
                 first = False
             else:
-                buff.append("\t%s%s," % (event, self.enum_suffix))
+                buff.append(f"\t{event}{self.enum_suffix},")
 
-        buff.append("\tevent_max%s" % self.enum_suffix)
+        buff.append(f"\tevent_max{self.enum_suffix}")
 
         return buff
 
@@ -77,7 +77,7 @@ class Dot2c(Automata):
 
     def format_events_enum(self):
         buff = []
-        buff.append("enum %s {" % self.enum_events_def)
+        buff.append(f"enum {self.enum_events_def} {{")
         buff.append(self.get_enum_events_string())
         buff.append("};\n")
 
@@ -93,25 +93,25 @@ class Dot2c(Automata):
             min_type = "unsigned int"
 
         if self.states.__len__() > 1000000:
-            raise AutomataError("Too many states: %d" % self.states.__len__())
+            raise AutomataError(f"Too many states: {self.states.__len__()}")
 
         return min_type
 
     def format_automaton_definition(self):
         min_type = self.get_minimun_type()
         buff = []
-        buff.append("struct %s {" % self.struct_automaton_def)
-        buff.append("\tchar *state_names[state_max%s];" % (self.enum_suffix))
-        buff.append("\tchar *event_names[event_max%s];" % (self.enum_suffix))
-        buff.append("\t%s function[state_max%s][event_max%s];" % (min_type, self.enum_suffix, self.enum_suffix))
-        buff.append("\t%s initial_state;" % min_type)
-        buff.append("\tbool final_states[state_max%s];" % (self.enum_suffix))
+        buff.append(f"struct {self.struct_automaton_def} {{")
+        buff.append(f"\tchar *state_names[state_max{self.enum_suffix}];")
+        buff.append(f"\tchar *event_names[event_max{self.enum_suffix}];")
+        buff.append(f"\t{min_type} function[state_max{self.enum_suffix}][event_max{self.enum_suffix}];")
+        buff.append(f"\t{min_type} initial_state;")
+        buff.append(f"\tbool final_states[state_max{self.enum_suffix}];")
         buff.append("};\n")
         return buff
 
     def format_aut_init_header(self):
         buff = []
-        buff.append("static const struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        buff.append(f"static const struct {self.struct_automaton_def} {self.var_automaton_def} = {{")
         return buff
 
     def __get_string_vector_per_line_content(self, buff):
@@ -169,9 +169,9 @@ class Dot2c(Automata):
                     next_state = self.function[x][y] + self.enum_suffix
 
                 if linetoolong:
-                    line += "\t\t\t%s" % next_state
+                    line += f"\t\t\t{next_state}"
                 else:
-                    line += "%*s" % (maxlen, next_state)
+                    line += f"{next_state:>{maxlen}}"
                 if y != nr_events-1:
                     line += ",\n" if linetoolong else ", "
                 else:
@@ -215,7 +215,7 @@ class Dot2c(Automata):
 
     def format_aut_init_final_states(self):
        buff = []
-       buff.append("\t.final_states = { %s }," % self.get_aut_init_final_states())
+       buff.append(f"\t.final_states = {{ {self.get_aut_init_final_states()} }},")
 
        return buff
 
@@ -231,7 +231,7 @@ class Dot2c(Automata):
 
     def format_invalid_state(self):
         buff = []
-        buff.append("#define %s state_max%s\n" % (self.invalid_state_str, self.enum_suffix))
+        buff.append(f"#define {self.invalid_state_str} state_max{self.enum_suffix}\n")
 
         return buff
 
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index ed0a3c9011069..1c0d0235bdf62 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -19,7 +19,7 @@ class dot2k(Monitor, Dot2c):
         self.monitor_type = MonitorType
         Monitor.__init__(self, extra_params)
         Dot2c.__init__(self, file_path, extra_params.get("model_name"))
-        self.enum_suffix = "_%s" % self.name
+        self.enum_suffix = f"_{self.name}"
 
     def fill_monitor_type(self):
         return self.monitor_type.upper()
@@ -27,7 +27,7 @@ class dot2k(Monitor, Dot2c):
     def fill_tracepoint_handlers_skel(self):
         buff = []
         for event in self.events:
-            buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
+            buff.append(f"static void handle_{event}(void *data, /* XXX: fill header */)")
             buff.append("{")
             handle = "handle_event"
             if self.is_start_event(event):
@@ -38,9 +38,9 @@ class dot2k(Monitor, Dot2c):
                 handle = "handle_start_run_event"
             if self.monitor_type == "per_task":
                 buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
-                buff.append("\tda_%s_%s(p, %s%s);" % (handle, self.name, event, self.enum_suffix));
+                buff.append(f"\tda_{handle}_{self.name}(p, {event}{self.enum_suffix});");
             else:
-                buff.append("\tda_%s_%s(%s%s);" % (handle, self.name, event, self.enum_suffix));
+                buff.append(f"\tda_{handle}_{self.name}({event}{self.enum_suffix});");
             buff.append("}")
             buff.append("")
         return '\n'.join(buff)
@@ -48,20 +48,20 @@ class dot2k(Monitor, Dot2c):
     def fill_tracepoint_attach_probe(self):
         buff = []
         for event in self.events:
-            buff.append("\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
+            buff.append(f"\trv_attach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_{event});")
         return '\n'.join(buff)
 
     def fill_tracepoint_detach_helper(self):
         buff = []
         for event in self.events:
-            buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
+            buff.append(f"\trv_detach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_{event});")
         return '\n'.join(buff)
 
     def fill_model_h_header(self):
         buff = []
         buff.append("/* SPDX-License-Identifier: GPL-2.0 */")
         buff.append("/*")
-        buff.append(" * Automatically generated C representation of %s automaton" % (self.name))
+        buff.append(f" * Automatically generated C representation of {self.name} automaton")
         buff.append(" * For further information about this format, see kernel documentation:")
         buff.append(" *   Documentation/trace/rv/deterministic_automata.rst")
         buff.append(" */")
@@ -73,10 +73,10 @@ class dot2k(Monitor, Dot2c):
         #
         # Adjust the definition names
         #
-        self.enum_states_def = "states_%s" % self.name
-        self.enum_events_def = "events_%s" % self.name
-        self.struct_automaton_def = "automaton_%s" % self.name
-        self.var_automaton_def = "automaton_%s" % self.name
+        self.enum_states_def = f"states_{self.name}"
+        self.enum_events_def = f"events_{self.name}"
+        self.struct_automaton_def = f"automaton_{self.name}"
+        self.var_automaton_def = f"automaton_{self.name}"
 
         buff = self.fill_model_h_header()
         buff += self.format_model()
@@ -111,8 +111,8 @@ class dot2k(Monitor, Dot2c):
             tp_args.insert(0, tp_args_id)
         tp_proto_c = ", ".join([a+b for a,b in tp_args])
         tp_args_c = ", ".join([b for a,b in tp_args])
-        buff.append("	     TP_PROTO(%s)," % tp_proto_c)
-        buff.append("	     TP_ARGS(%s)" % tp_args_c)
+        buff.append(f"	     TP_PROTO({tp_proto_c}),")
+        buff.append(f"	     TP_ARGS({tp_args_c})")
         return '\n'.join(buff)
 
     def fill_main_c(self):
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index af1662e2c20a7..6d16fb68798a7 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -40,7 +40,7 @@ class RVGenerator:
         if platform.system() != "Linux":
             raise OSError("I can only run on Linux.")
 
-        kernel_path = os.path.join("/lib/modules/%s/build" % platform.release(), self.rv_dir)
+        kernel_path = os.path.join(f"/lib/modules/{platform.release()}/build", self.rv_dir)
 
         # if the current kernel is from a distro this may not be a full kernel tree
         # verify that one of the files we are going to modify is available
@@ -69,11 +69,11 @@ class RVGenerator:
             return self._read_file(path)
 
     def fill_parent(self):
-        return "&rv_%s" % self.parent if self.parent else "NULL"
+        return f"&rv_{self.parent}" if self.parent else "NULL"
 
     def fill_include_parent(self):
         if self.parent:
-            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.parent)
+            return f"#include <monitors/{self.parent}/{self.parent}.h>\n"
         return ""
 
     def fill_tracepoint_handlers_skel(self):
@@ -119,7 +119,7 @@ class RVGenerator:
         buff = []
         buff.append("	# XXX: add dependencies if there")
         if self.parent:
-            buff.append("	depends on RV_MON_%s" % self.parent.upper())
+            buff.append(f"	depends on RV_MON_{self.parent.upper()}")
             buff.append("	default y")
         return '\n'.join(buff)
 
@@ -145,31 +145,30 @@ class RVGenerator:
         monitor_class_type = self.fill_monitor_class_type()
         if self.auto_patch:
             self._patch_file("rv_trace.h",
-                            "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
-                            "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
-            return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
+                            f"// Add new monitors based on CONFIG_{monitor_class_type} here",
+                            f"#include <monitors/{self.name}/{self.name}_trace.h>")
+            return f"  - Patching {self.rv_dir}/rv_trace.h, double check the result"
 
-        return """  - Edit %s/rv_trace.h:
-Add this line where other tracepoints are included and %s is defined:
-#include <monitors/%s/%s_trace.h>
-""" % (self.rv_dir, monitor_class_type, self.name, self.name)
+        return f"""  - Edit {self.rv_dir}/rv_trace.h:
+Add this line where other tracepoints are included and {monitor_class_type} is defined:
+#include <monitors/{self.name}/{self.name}_trace.h>
+"""
 
     def _kconfig_marker(self, container=None) -> str:
-        return "# Add new %smonitors here" % (container + " "
-                                              if container else "")
+        return f"# Add new {container + ' ' if container else ''}monitors here"
 
     def fill_kconfig_tooltip(self):
         if self.auto_patch:
             # monitors with a container should stay together in the Kconfig
             self._patch_file("Kconfig",
                              self._kconfig_marker(self.parent),
-                            "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
-            return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
+                            f"source \"kernel/trace/rv/monitors/{self.name}/Kconfig\"")
+            return f"  - Patching {self.rv_dir}/Kconfig, double check the result"
 
-        return """  - Edit %s/Kconfig:
+        return f"""  - Edit {self.rv_dir}/Kconfig:
 Add this line where other monitors are included:
-source \"kernel/trace/rv/monitors/%s/Kconfig\"
-""" % (self.rv_dir, self.name)
+source \"kernel/trace/rv/monitors/{self.name}/Kconfig\"
+"""
 
     def fill_makefile_tooltip(self):
         name = self.name
@@ -177,18 +176,18 @@ source \"kernel/trace/rv/monitors/%s/Kconfig\"
         if self.auto_patch:
             self._patch_file("Makefile",
                             "# Add new monitors here",
-                            "obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o" % (name_up, name, name))
-            return "  - Patching %s/Makefile, double check the result" % self.rv_dir
+                            f"obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o")
+            return f"  - Patching {self.rv_dir}/Makefile, double check the result"
 
-        return """  - Edit %s/Makefile:
+        return f"""  - Edit {self.rv_dir}/Makefile:
 Add this line where other monitors are included:
-obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
-""" % (self.rv_dir, name_up, name, name)
+obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
+"""
 
     def fill_monitor_tooltip(self):
         if self.auto_patch:
-            return "  - Monitor created in %s/monitors/%s" % (self.rv_dir, self. name)
-        return "  - Move %s/ to the kernel's monitor directory (%s/monitors)" % (self.name, self.rv_dir)
+            return f"  - Monitor created in {self.rv_dir}/monitors/{self.name}"
+        return f"  - Move {self.name}/ to the kernel's monitor directory ({self.rv_dir}/monitors)"
 
     def __create_directory(self):
         path = self.name
@@ -205,13 +204,13 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
         file.close()
 
     def _create_file(self, file_name, content):
-        path = "%s/%s" % (self.name, file_name)
+        path = f"{self.name}/{file_name}"
         if self.auto_patch:
             path = os.path.join(self.rv_dir, "monitors", path)
         self.__write_file(path, content)
 
     def __get_main_name(self):
-        path = "%s/%s" % (self.name, "main.c")
+        path = f"{self.name}/main.c"
         if not os.path.exists(path):
             return "main.c"
         return "__main.c"
@@ -221,11 +220,11 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
 
         self.__create_directory()
 
-        path = "%s.c" % self.name
+        path = f"{self.name}.c"
         self._create_file(path, main_c)
 
         model_h = self.fill_model_h()
-        path = "%s.h" % self.name
+        path = f"{self.name}.h"
         self._create_file(path, model_h)
 
         kconfig = self.fill_kconfig()
@@ -256,5 +255,5 @@ class Monitor(RVGenerator):
     def print_files(self):
         super().print_files()
         trace_h = self.fill_trace_h()
-        path = "%s_trace.h" % self.name
+        path = f"{self.name}_trace.h"
         self._create_file(path, trace_h)
diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index b075f98d50c47..fa9ea6d597095 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -73,7 +73,7 @@ class ltl2k(generator.Monitor):
         ]
 
         for node in self.ba:
-            buf.append("\tS%i," % node.id)
+            buf.append(f"\tS{node.id},")
         buf.append("\tRV_NUM_BA_STATES")
         buf.append("};")
         buf.append("static_assert(RV_NUM_BA_STATES <= RV_MAX_BA_STATES);")
@@ -82,7 +82,7 @@ class ltl2k(generator.Monitor):
     def _fill_atoms(self):
         buf = ["enum ltl_atom {"]
         for a in sorted(self.atoms):
-            buf.append("\tLTL_%s," % a)
+            buf.append(f"\tLTL_{a},")
         buf.append("\tLTL_NUM_ATOM")
         buf.append("};")
         buf.append("static_assert(LTL_NUM_ATOM <= RV_MAX_LTL_ATOM);")
@@ -96,7 +96,7 @@ class ltl2k(generator.Monitor):
         ]
 
         for name in self.atoms_abbr:
-            buf.append("\t\t\"%s\"," % name)
+            buf.append(f"\t\t\"{name}\",")
 
         buf.extend([
             "\t};",
@@ -113,19 +113,19 @@ class ltl2k(generator.Monitor):
                 continue
 
             if isinstance(node.op, ltl2ba.AndOp):
-                buf.append("\tbool %s = %s && %s;" % (node, node.op.left, node.op.right))
+                buf.append(f"\tbool {node} = {node.op.left} && {node.op.right};")
                 required_values |= {str(node.op.left), str(node.op.right)}
             elif isinstance(node.op, ltl2ba.OrOp):
-                buf.append("\tbool %s = %s || %s;" % (node, node.op.left, node.op.right))
+                buf.append(f"\tbool {node} = {node.op.left} || {node.op.right};")
                 required_values |= {str(node.op.left), str(node.op.right)}
             elif isinstance(node.op, ltl2ba.NotOp):
-                buf.append("\tbool %s = !%s;" % (node, node.op.child))
+                buf.append(f"\tbool {node} = !{node.op.child};")
                 required_values.add(str(node.op.child))
 
         for atom in self.atoms:
             if atom.lower() not in required_values:
                 continue
-            buf.append("\tbool %s = test_bit(LTL_%s, mon->atoms);" % (atom.lower(), atom))
+            buf.append(f"\tbool {atom.lower()} = test_bit(LTL_{atom}, mon->atoms);")
 
         buf.reverse()
 
@@ -153,7 +153,7 @@ class ltl2k(generator.Monitor):
         ])
 
         for node in self.ba:
-            buf.append("\tcase S%i:" % node.id)
+            buf.append(f"\tcase S{node.id}:")
 
             for o in sorted(node.outgoing):
                 line   = "\t\tif "
@@ -163,7 +163,7 @@ class ltl2k(generator.Monitor):
                 lines = break_long_line(line, indent)
                 buf.extend(lines)
 
-                buf.append("\t\t\t__set_bit(S%i, next);" % o.id)
+                buf.append(f"\t\t\t__set_bit(S{o.id}, next);")
             buf.append("\t\tbreak;")
         buf.extend([
             "\t}",
@@ -197,7 +197,7 @@ class ltl2k(generator.Monitor):
             lines = break_long_line(line, indent)
             buf.extend(lines)
 
-            buf.append("\t\t__set_bit(S%i, mon->states);" % node.id)
+            buf.append(f"\t\t__set_bit(S{node.id}, mon->states);")
         buf.append("}")
         return buf
 
@@ -205,23 +205,21 @@ class ltl2k(generator.Monitor):
         buff = []
         buff.append("static void handle_example_event(void *data, /* XXX: fill header */)")
         buff.append("{")
-        buff.append("\tltl_atom_update(task, LTL_%s, true/false);" % self.atoms[0])
+        buff.append(f"\tltl_atom_update(task, LTL_{self.atoms[0]}, true/false);")
         buff.append("}")
         buff.append("")
         return '\n'.join(buff)
 
     def fill_tracepoint_attach_probe(self):
-        return "\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_example_event);" \
-                % self.name
+        return f"\trv_attach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_example_event);"
 
     def fill_tracepoint_detach_helper(self):
-        return "\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_sample_event);" \
-                % self.name
+        return f"\trv_detach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_sample_event);"
 
     def fill_atoms_init(self):
         buff = []
         for a in self.atoms:
-            buff.append("\tltl_atom_set(mon, LTL_%s, true/false);" % a)
+            buff.append(f"\tltl_atom_set(mon, LTL_{a}, true/false);")
         return '\n'.join(buff)
 
     def fill_model_h(self):
-- 
2.52.0

