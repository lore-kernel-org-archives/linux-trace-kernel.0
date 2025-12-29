Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB774246BC5;
	Mon, 29 Dec 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051393; cv=none; b=eMgPTJ58I4Ok5O5Dl/7IVbhznKUybbifJvL3EEtNaPeqOL5b0phV1l5vTEtTy/gCDY7TPF3g48UgkmQynPF3PpD0bPF6wTOlUaduNAghW5luO9dGHtKNTQgPnFfCHx2VPM0XwwZZHvWRzYrJw+/X4zEmxtKp5jcDK0MYL7TFSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051393; c=relaxed/simple;
	bh=CB44Eysb/KH8ZRHxDLYPbxtTHagaGYqI8hBSMqf7ftw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJMib+uUTP0Ag1gfNl23weE/KlSpaiPZYLZljbBg7I/bWc27GJQKMcVinTfsaC3FMcBi/KhkkYv99Y/ELgl/z/wbWUxqYXPXTQMi0o0X+vUrwsq7ZL5NvmRpH6C9M3WnkSkTx8Fp1kLD1HdRZGEZiU1+4FkdNjrlwYqH5zT3NIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 091511A6DF0;
	Mon, 29 Dec 2025 23:36:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 0287F2000D;
	Mon, 29 Dec 2025 23:36:26 +0000 (UTC)
Date: Mon, 29 Dec 2025 18:36:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Allow perf to read synthetic events
Message-ID: <20251229183632.7b518b8d@gandalf.local.home>
In-Reply-To: <20251229174901.0e62eab0@gandalf.local.home>
References: <20251217113920.50b56246@gandalf.local.home>
	<aVG2VoBpFoEEE1gG@krava>
	<20251229174901.0e62eab0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0287F2000D
X-Stat-Signature: mqgirosjkj85ehtw6ttbmyeef54kmtzo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18U27ymyHr7ID7EDKNZEETzfR9bZjlTL+Y=
X-HE-Tag: 1767051386-918152
X-HE-Meta: U2FsdGVkX1/U58kF5Tx+iM7QiV+01US94F5kihi8pzOJwF37VDPmSmwna2kqmHMDDRmQ5k81D8P+4YT5mqiEDIbB8Q7hfgpCSG1+RWUsBmsokbJkqYCUBwCDSuQ7uhcT+hftfoGr+ZsJiT7X3cUY3qGBexP0ABObMSk0YRcagDX4g8dwmz5JoCJGWXzEaCUvnBP1g7yeOa34ekKe90ZiyHV7ji+l+JmzAqFyLMHUGd/Rh0ZztGSEsYiH4qJUX/vyvlPYrvx7ai+UfC8JE7EHCsDtsTJFPr4J4bSGfUd7Bui8y1WLeVDD5F7WZZeSRIVW/uBMW75BM+G+7uBhi4MXRwNo5q6cUO3ua4Lp759quI9wMuTbAPBl4wICoicP0WdHXJQ9MGzeETR8mZTY0Xh133EVTy7tHhOf

On Mon, 29 Dec 2025 17:49:01 -0500
Steven Rostedt <steven@rostedt.org> wrote:

> Looks like I only need to add "__get_stacktrace()" to the libtraceevent parsing.

The below patch appears to work:

           <...>-22    [001] d..5.  2891.837516: block_lat:            pid=22 delta=159 stack=
=> __schedule+0xded
=> schedule+0x123
=> io_schedule+0x44
=> bit_wait_io+0x11
=> __wait_on_bit+0x4a
=> out_of_line_wait_on_bit+0x9d
=> ext4_read_bh+0x95
=> ext4_bread+0x51
=> __ext4_read_dirblock+0x45
=> htree_dirblock_to_tree+0x76
=> ext4_htree_fill_tree+0x3b1
=> ext4_readdir+0xa9b
=> iterate_dir+0xef
=> __se_sys_getdents64+0x76
=> do_syscall_64+0x93
           <...>-254   [004] d..5.  2892.173786: block_lat:            pid=254 delta=57 stack=
=> __schedule+0xded
=> schedule+0x123
=> io_schedule+0x44
=> bit_wait_io+0x11
=> __wait_on_bit+0x4a
=> out_of_line_wait_on_bit+0x9d
=> ext4_read_bh+0x95
=> ext4_bread+0x51
=> __ext4_read_dirblock+0x45
=> htree_dirblock_to_tree+0x76
=> ext4_htree_fill_tree+0x1e5
=> ext4_readdir+0xa9b
=> iterate_dir+0xef
=> __se_sys_getdents64+0x76
=> do_syscall_64+0x93

-- Steve

diff --git a/include/traceevent/event-parse.h b/include/traceevent/event-parse.h
index ebfc2c7..9c1abfa 100644
--- a/include/traceevent/event-parse.h
+++ b/include/traceevent/event-parse.h
@@ -138,6 +138,11 @@ struct tep_print_arg_bitmask {
 	struct tep_format_field	*field;
 };
 
+struct tep_print_arg_stacktrace {
+	char			*stacktrace;
+	struct tep_format_field	*field;
+};
+
 struct tep_print_arg_field {
 	char			*name;
 	struct tep_format_field	*field;
@@ -215,6 +220,7 @@ enum tep_print_arg_type {
 	TEP_PRINT_DYNAMIC_ARRAY_LEN,
 	TEP_PRINT_HEX_STR,
 	TEP_PRINT_CPUMASK,
+	TEP_PRINT_STACKTRACE,
 };
 
 struct tep_print_arg {
@@ -231,6 +237,7 @@ struct tep_print_arg {
 		struct tep_print_arg_func	func;
 		struct tep_print_arg_string	string;
 		struct tep_print_arg_bitmask	bitmask;
+		struct tep_print_arg_stacktrace	stacktrace;
 		struct tep_print_arg_op		op;
 		struct tep_print_arg_dynarray	dynarray;
 	};
diff --git a/src/event-parse.c b/src/event-parse.c
index 939b0a8..09d9092 100644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -1129,6 +1129,9 @@ static void free_arg(struct tep_print_arg *arg)
 		free_arg(arg->op.left);
 		free_arg(arg->op.right);
 		break;
+	case TEP_PRINT_STACKTRACE:
+		free(arg->stacktrace.stacktrace);
+		break;
 	case TEP_PRINT_FUNC:
 		while (arg->func.args) {
 			farg = arg->func.args;
@@ -2895,6 +2898,7 @@ static int arg_num_eval(struct tep_print_arg *arg, long long *val)
 	case TEP_PRINT_BSTRING:
 	case TEP_PRINT_BITMASK:
 	case TEP_PRINT_CPUMASK:
+	case TEP_PRINT_STACKTRACE:
 	default:
 		do_warning("invalid eval type %d", arg->type);
 		ret = 0;
@@ -2925,6 +2929,7 @@ static char *arg_eval (struct tep_print_arg *arg)
 	case TEP_PRINT_BSTRING:
 	case TEP_PRINT_BITMASK:
 	case TEP_PRINT_CPUMASK:
+	case TEP_PRINT_STACKTRACE:
 	default:
 		do_warning("invalid eval type %d", arg->type);
 		break;
@@ -3462,6 +3467,34 @@ process_cpumask(struct tep_event *event __maybe_unused, struct tep_print_arg *ar
 	return type;
 }
 
+static enum tep_event_type
+process_stacktrace(struct tep_event *event, struct tep_print_arg *arg, char **tok)
+{
+	enum tep_event_type type;
+	char *token;
+
+	if (read_expect_type(event->tep, TEP_EVENT_ITEM, &token) < 0)
+		goto out_free;
+
+	arg->type = TEP_PRINT_STACKTRACE;
+	arg->stacktrace.stacktrace = token;
+	arg->stacktrace.field = NULL;
+
+	if (read_expected(event->tep, TEP_EVENT_DELIM, ")") < 0)
+		goto out_err;
+
+	type = read_token(event->tep, &token);
+	*tok = token;
+
+	return type;
+
+ out_free:
+	free_token(token);
+ out_err:
+	*tok = NULL;
+	return TEP_EVENT_ERROR;
+}
+
 static struct tep_function_handler *
 find_func_handler(struct tep_handle *tep, char *func_name)
 {
@@ -3750,6 +3783,10 @@ process_function(struct tep_event *event, struct tep_print_arg *arg,
 		free_token(token);
 		return process_dynamic_array_len(event, arg, tok);
 	}
+	if (strcmp(token, "__get_stacktrace") == 0) {
+		free_token(token);
+		return process_stacktrace(event, arg, tok);
+	}
 	if (strcmp(token, "__builtin_expect") == 0) {
 		free_token(token);
 		return process_builtin_expect(event, arg, tok);
@@ -4414,6 +4451,7 @@ eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg
 	case TEP_PRINT_BSTRING:
 	case TEP_PRINT_BITMASK:
 	case TEP_PRINT_CPUMASK:
+	case TEP_PRINT_STACKTRACE:
 		return 0;
 	case TEP_PRINT_FUNC: {
 		struct trace_seq s;
@@ -4859,6 +4897,33 @@ more:
 	free(str);
 }
 
+static void print_stacktrace_to_seq(struct tep_handle *tep,
+				    struct trace_seq *s, const char *format,
+				    int len_arg, const void *data, int size)
+{
+	int nr_funcs = size / tep->long_size;
+	struct func_map *func;
+	unsigned long long val;
+
+	trace_seq_putc(s, '\n');
+
+	/* The first entry is a counter, skip it */
+	data += tep->long_size;
+
+	for (int i = 1; i < nr_funcs; i++) {
+		trace_seq_puts(s, "=> ");
+		val = tep_read_number(tep, data, tep->long_size);
+		func = find_func(tep, val);
+		if (func) {
+			trace_seq_puts(s, func->func);
+			trace_seq_printf(s, "+0x%llx\n", val - func->addr);
+		} else {
+			trace_seq_printf(s, "%llx\n", val);
+		}
+		data += tep->long_size;
+	}
+}
+
 static void print_str_arg(struct trace_seq *s, void *data, int size,
 			  struct tep_event *event, const char *format,
 			  int len_arg, struct tep_print_arg *arg)
@@ -5097,6 +5162,17 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 				     data + offset, len);
 		break;
 	}
+	case TEP_PRINT_STACKTRACE: {
+		if (!arg->stacktrace.field) {
+			arg->stacktrace.field = tep_find_any_field(event, arg->stacktrace.stacktrace);
+			if (!arg->stacktrace.field)
+				break;
+		}
+		dynamic_offset_field(tep, arg->stacktrace.field, data, size, &offset, &len);
+		print_stacktrace_to_seq(tep, s, format, len_arg,
+					data + offset, len);
+		break;
+	}
 	case TEP_PRINT_OP:
 		/*
 		 * The only op for string should be ? :
