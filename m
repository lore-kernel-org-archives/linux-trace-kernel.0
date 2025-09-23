Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048AF324B20;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632755; cv=none; b=ZYnbJ6yJGv+shKFaOdtFwv5+2JeV7cl1Hu0GYJ/ueR+BDBu2x4n2IN+qrZkZhGqw4ZhIds7pSL0ORpVHz6d39UmMQCSlGh2uxzV1bdinl47hDlj1rxbr8Viyb318VJjydzoVnVGhrovimkweniObfky0IWDsEEmC3PuASlEMBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632755; c=relaxed/simple;
	bh=RYaT0rLWqlos3+8ZsCiH/EtkBxlq5yK6xADm0AiDDkA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p16nUBI2TWXC2foNouVnemw1nBH1hioeu14c5BM7TE2VAnlEwvSfT6X124P5c9QRHPhaoTGRSG0cEUl9U1BfDvNhr8wpae6k0VQBus83408HRHm0TkDTDz01nWn9u5VPswd3RED6UBSefLHzt5YUOdGxKHAvadhcPEA2HVdqTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swed5O5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swed5O5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5384C19424;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632754;
	bh=RYaT0rLWqlos3+8ZsCiH/EtkBxlq5yK6xADm0AiDDkA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Swed5O5o+NQiXwmws1QwYO32bREsbCoFhwwljzcNaHBw+X910M+h22I018olPDveN
	 aE/xJWNPWauKtKl6aDhPhhqJfoCqVeyBPqEAYk70N2MgZUtY/P05ocWNC6IJnXYf8t
	 LaKW3e5QEa/K+kUr74MElLgzCevr+FXG6iw5vBI+ZXpC3heJwmfSUC8AhhZdjK1H2r
	 0zu80dafgznEEArsePHiuAirYgAw+CMduOZu+CorzLzHD+bvSWgDfRTg1bw3PGl8Gs
	 b6MsPcSNsJl/rGzv9w3c98/sEke2wZdaxT0bagwNvRiLZFNRFiqcts1r5U1XcpKgX2
	 Tc0pCVj6pVi7A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12ji-0000000Cor7-1j0i;
	Tue, 23 Sep 2025 09:07:14 -0400
Message-ID: <20250923130714.265621062@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:05:02 -0400
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
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH v2 5/8] tracing: Display some syscall arrays as strings
References: <20250923130457.901085554@kernel.org>
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
Changes since v1: https://lore.kernel.org/20250805193235.416382557@kernel.org

- Hide kexec_file_load around
  #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
  to not break the i386 build.

 include/trace/syscall.h       |  4 +++-
 kernel/trace/trace_syscalls.c | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

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
index 7658b592c55f..64be38cf790d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -184,7 +184,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
 
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
 			trace_seq_printf(s, " \"%.*s\"", len, ptr);
 			continue;
 		}
@@ -249,6 +249,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 {
+	bool is_string = entry->user_arg_is_str;
 	int i;
 	int pos = 0;
 
@@ -266,7 +267,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 			continue;
 
 		/* Add the format for the user space string or array */
-		if (entry->user_arg_size < 0)
+		if (entry->user_arg_size < 0 || is_string)
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " (%%s)");
@@ -279,7 +280,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 		/* The user space data for arg has name __<arg>_val */
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || is_string) {
 			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
 					entry->args[i]);
 		} else {
@@ -851,6 +852,21 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
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
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
+	/* user arg 4 with size arg at 3 as string */
+	case __NR_kexec_file_load:
+		sys_data->user_mask = BIT(4);
+		sys_data->user_arg_size = 3;
+		sys_data->user_arg_is_str = 1;
+		break;
+#endif
 	/* user arg at position 0 */
 	case __NR_access:
 	case __NR_acct:
-- 
2.50.1


