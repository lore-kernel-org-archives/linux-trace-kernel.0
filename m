Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B021A94F;
	Tue,  5 Aug 2025 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422325; cv=none; b=jUscMd1bu/aItLBfHqOf6xDZPuvUKwE/fvtsZVuVLiFJ0aq4BmI06zcoFWoGVzKYvpQOq/VivajjNdGAYK4dBuUbphw5bsoLiWwiM9H0A9NoXA+BckZTyd7l/t+tg2Ge6/DI2An/hFjSbbHrDCZlMZ6cBzkhEmF0QqymZGSOFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422325; c=relaxed/simple;
	bh=8i3aqlzoT8TMSviMiyBc3heae3KFeVBohdAj9PXmGYc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JXZdu6p3/BwgCZPuF1Kz+Lm++Sd0iEWdxnEGmGMosrFKDUes7pmSq77F5p6zsR8rI8si7gPMkNSTEjH1gqo3S5+ZxsZrxZOm7xPIRDK9RcQMIR2HQpR0DyUy4LheFkKmzJS/LLSuNpHE3SfkaKUaoSgIe0kbDSYd8YhE+69YQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkmfNmqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkmfNmqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7F5C4CEF0;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754422325;
	bh=8i3aqlzoT8TMSviMiyBc3heae3KFeVBohdAj9PXmGYc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=RkmfNmqh7scWUBdb5gZtbLA+MTFKiWh7JHRmge2HEdPO2E0u3zn/+y82tAYjKGi8n
	 L6HKSC/8qZlb5APkVAIxxkk614uZQbdvA/54FPYs46H1KQz3duok+94XbrCeMwepNJ
	 A9PiKK+bUPLlPO5S4fwITyWB5DCWvtz98RSxdwec4Z+x5ArseCpI6H1UQeyzE7etvf
	 ANptwE8Oi9+++9YeFINTX6SlZLS5T5IGe6kfoBaavWj9jtYhzIdlKMK8fg6VQep/C6
	 2aOyxlaYXFYI9ys85YwEN8hCFh0sv7a6iGpD2NhO4lH48i3fKZZjqjJ1FslDcAoEBJ
	 1+Ir+48VM7IvQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ujNOl-0000000AtEw-2Mii;
	Tue, 05 Aug 2025 15:32:35 -0400
Message-ID: <20250805193235.416382557@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 05 Aug 2025 15:26:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 aahringo@redhat.com,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH 5/7] tracing: Display some syscall arrays as strings
References: <20250805192646.328291790@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some of the system calls that read a fixed length of memory from the user
space address are not arrays but strings. Take a bit away from the nb_args
field in the syscall meta data to use as a flag to denote that the system
call's user_arg_size is being used as a string. The nb_args should never
be more than 6, so 7 bits is plenty to hold that number. When the
user_arg_is_str flag that, when set, will display the data array from the
user space address as a string and not an array.

This will allow the output to look like this:

  sys_sethostname(name: 0x5584310eb2a0 "debian", len: 6)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/syscall.h       |  4 +++-
 kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 9413c139da66..0dd7f2b33431 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_arg_is_str: set if the arg for @user_arg_size is a string
  * @user_arg_size: holds @arg that has size of the user space to read
  * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
@@ -27,7 +28,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	u8		nb_args;
+	u8		nb_args:7;
+	u8		user_arg_is_str:1;
 	s8		user_arg_size;
 	short		user_mask;
 	const char	**types;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index b0a587f2e4b5..8c0142eea898 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -182,14 +182,13 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		val = *(int *)ptr;
 
 		ptr = (void *)ent + (val & 0xffff);
+		len = val >> 16;
 
-		if (entry->user_arg_size < 0) {
-			trace_seq_printf(s, " \"%s\"", ptr);
+		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
+			trace_seq_printf(s, " \"%.*s\"", len, ptr);
 			continue;
 		}
 
-		len = val >> 16;
-
 		val = trace->args[entry->user_arg_size];
 
 		trace_seq_puts(s, " (");
@@ -250,6 +249,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 {
+	bool is_string = entry->user_arg_is_str;
 	int i;
 	int pos = 0;
 
@@ -267,7 +267,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 			continue;
 
 		/* Add the format for the user space string or array */
-		if (entry->user_arg_size < 0)
+		if (entry->user_arg_size < 0 || is_string)
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " (%%s)");
@@ -280,7 +280,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 		/* The user space data for arg has name __<arg>_val */
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || is_string) {
 			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
 					entry->args[i]);
 		} else {
@@ -872,6 +872,19 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 		sys_data->user_mask = BIT(1);
 		sys_data->user_arg_size = 2;
 		break;
+	/* user arg 0 with size arg at 1 as string */
+	case __NR_setdomainname:
+	case __NR_sethostname:
+		sys_data->user_mask = BIT(0);
+		sys_data->user_arg_size = 1;
+		sys_data->user_arg_is_str = 1;
+		break;
+	/* user arg 4 with size arg at 3 as string */
+	case __NR_kexec_file_load:
+		sys_data->user_mask = BIT(4);
+		sys_data->user_arg_size = 3;
+		sys_data->user_arg_is_str = 1;
+		break;
 	/* user arg at position 0 */
 	case __NR_access:
 	case __NR_acct:
-- 
2.47.2


