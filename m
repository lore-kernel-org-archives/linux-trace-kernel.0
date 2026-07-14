Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2743596F8;
	Tue, 14 Jul 2026 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991400; cv=none; b=eUKNkFkLEuvCUImfuOjc8kHc3CC3AuyDwcoShLuLiKU621sONLJVOhqM5TlbIybiOfNUdkb1gvk6jp3cPaxo3cFvYRZu4wSwWAP1hdtWsffayRBl8whnhOyVYAPwBTZIBYkQ899fd2BcVaH4GCipHGAQenc9nn5jLEqEi7COilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991400; c=relaxed/simple;
	bh=hqELA/fl1LAqzz8E8IRdPGy8XOdMNte2Dui+FJdM+aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyyL6WvZRaSj26sIV2iqZJZ71zlUSqgxtKOzRhllNOhNEsfgyMF5YOaQvVwUPecEBE5Ut6dl8mvTDGeLear61vE0zP91EyPi6lBtoOVattN1j25+xSIIUfxDFLlCrPaR5o3/whBKf72waUjdxSnhxnT6tRyEihYbUFCD5u2k8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjPCW9Gt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjPCW9Gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5326F1F000E9;
	Tue, 14 Jul 2026 01:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991399;
	bh=ykkygFjoUseT4cJdY6LDUUSLsLeCSFMWe0Bi0JBfXDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjPCW9GtL7QbYSzkHI380R/7m34a30LojS9b43U0wcoULZx6QXfl6lutksPT0VDkn
	 qd8b5u96tq1bJFcQfrb70Sn489V9f3GXMDAm8JIHymPVgpgUE+dj6S7p0/fid9YLOj
	 zL4deBogTXHjmQUoQARbGpdpOiOvqlibmfeGGmfqA5WDhYW+266ZGqNjvri/tCznmB
	 oVOQcKqV5hMUcVwGFxf1NhTeq27/gNpAepv/iEgLwYuvhBjax17Lgh7T36NgtTrG2l
	 Wna8OkZ9oT/yXw/oSMkAd9zmc5s0YrjdT30kKLM9hWMWlXEKXsQ/1lxvMgNHWPt5o7
	 RsB2IO67o85Gw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/5] tracing/probes: Sort ERRORS list in trace_probe.h alphabetically
Date: Tue, 14 Jul 2026 10:09:55 +0900
Message-ID: <178399139516.27810.14930549550788208142.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178399136606.27810.4469135881050354189.stgit@devnote2>
References: <178399136606.27810.4469135881050354189.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

Sort the C-macro ERRORS list alphabetically in trace_probe.h to make
it easier to find and maintain error entries.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.h |  160 ++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index e6268a8dc378..e64e323244a5 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -512,95 +512,95 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 
 #undef ERRORS
 #define ERRORS	\
-	C(FILE_NOT_FOUND,	"Failed to find the given file"),	\
-	C(NO_REGULAR_FILE,	"Not a regular file"),			\
-	C(BAD_REFCNT,		"Invalid reference counter offset"),	\
-	C(REFCNT_OPEN_BRACE,	"Reference counter brace is not closed"), \
-	C(BAD_REFCNT_SUFFIX,	"Reference counter has wrong suffix"),	\
-	C(BAD_UPROBE_OFFS,	"Invalid uprobe offset"),		\
-	C(BAD_MAXACT_TYPE,	"Maxactive is only for function exit"),	\
-	C(BAD_MAXACT,		"Invalid maxactive number"),		\
-	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
-	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
-	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
-	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
-	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
-	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
-	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
-	C(NO_GROUP_NAME,	"Group name is not specified"),		\
-	C(GROUP_TOO_LONG,	"Group name is too long"),		\
-	C(BAD_GROUP_NAME,	"Group name must follow the same rules as C identifiers"), \
-	C(NO_EVENT_NAME,	"Event name is not specified"),		\
-	C(EVENT_TOO_LONG,	"Event name is too long"),		\
-	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"), \
-	C(EVENT_EXIST,		"Given group/event name is already used by another event"), \
-	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
-	C(NO_RETVAL,		"This function returns 'void' type"),	\
-	C(BAD_STACK_NUM,	"Invalid stack number"),		\
+	C(ARGIDX_2BIG,		"$argN index is too big"),		\
+	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),	\
+	C(ARG_NAME_TOO_LONG,	"Argument name is too long"),		\
+	C(ARG_TOO_LONG,		"Argument expression is too long"),		\
+	C(ARRAY_NO_CLOSE,	"Array is not closed"),		\
+	C(ARRAY_TOO_BIG,	"Array number is too big"),		\
+	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"),		\
+	C(BAD_ARG_NAME,		"Argument name must follow the same rules as C identifiers"),	\
 	C(BAD_ARG_NUM,		"Invalid argument number"),		\
-	C(BAD_VAR,		"Invalid $-variable specified"),	\
-	C(BAD_REG_NAME,		"Invalid register name"),		\
-	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
-	C(BAD_IMM,		"Invalid immediate value"),		\
-	C(IMMSTR_NO_CLOSE,	"String is not closed with '\"'"),	\
-	C(FILE_ON_KPROBE,	"File offset is not available for kernel probes"), \
-	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
-	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
-	C(TOO_MANY_OPS,		"Dereference is too much nested"), 	\
-	C(DEREF_NEED_BRACE,	"Dereference needs a brace"),		\
+	C(BAD_ARRAY_NUM,	"Invalid array size"),		\
+	C(BAD_ARRAY_SUFFIX,	"Array has wrong suffix"),		\
+	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),	\
+	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),		\
+	C(BAD_BITFIELD,		"Invalid bitfield"),		\
+	C(BAD_BTF_TID,		"Failed to get BTF type info."),		\
 	C(BAD_DEREF_OFFS,	"Invalid dereference offset"),		\
-	C(DEREF_OPEN_BRACE,	"Dereference brace is not closed"),	\
-	C(COMM_CANT_DEREF,	"$comm can not be dereferenced"),	\
+	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"),	\
 	C(BAD_FETCH_ARG,	"Invalid fetch argument"),		\
-	C(ARRAY_NO_CLOSE,	"Array is not closed"),			\
-	C(BAD_ARRAY_SUFFIX,	"Array has wrong suffix"),		\
-	C(BAD_ARRAY_NUM,	"Invalid array size"),			\
-	C(ARRAY_TOO_BIG,	"Array number is too big"),		\
-	C(BAD_TYPE,		"Unknown type is specified"),		\
-	C(BAD_STRING,		"String accepts only memory argument"),	\
+	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
+	C(BAD_GROUP_NAME,	"Group name must follow the same rules as C identifiers"),	\
+	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
+	C(BAD_IMM,		"Invalid immediate value"),		\
+	C(BAD_INSN_BNDRY,	"Probe point is not an instruction boundary"),	\
+	C(BAD_MAXACT,		"Invalid maxactive number"),		\
+	C(BAD_MAXACT_TYPE,	"Maxactive is only for function exit"),	\
+	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
+	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),		\
+	C(BAD_REFCNT,		"Invalid reference counter offset"),		\
+	C(BAD_REFCNT_SUFFIX,	"Reference counter has wrong suffix"),	\
+	C(BAD_REG_NAME,		"Invalid register name"),		\
+	C(BAD_RETPROBE,		"Retprobe address must be an function entry"),	\
+	C(BAD_STACK_NUM,	"Invalid stack number"),		\
+	C(BAD_STRING,		"String accepts only memory argument"),		\
 	C(BAD_SYMSTRING,	"Symbol String doesn't accept data/userdata"),	\
-	C(BAD_BITFIELD,		"Invalid bitfield"),			\
-	C(ARG_NAME_TOO_LONG,	"Argument name is too long"),		\
-	C(NO_ARG_NAME,		"Argument name is not specified"),	\
-	C(BAD_ARG_NAME,		"Argument name must follow the same rules as C identifiers"), \
-	C(USED_ARG_NAME,	"This argument name is already used"),	\
-	C(ARG_TOO_LONG,		"Argument expression is too long"),	\
+	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),	\
+	C(BAD_TYPE,		"Unknown type is specified"),		\
+	C(BAD_TYPE4STR,		"This type does not fit for string."),	\
+	C(BAD_UPROBE_OFFS,	"Invalid uprobe offset"),		\
+	C(BAD_VAR,		"Invalid $-variable specified"),		\
+	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),	\
+	C(COMM_CANT_DEREF,	"$comm can not be dereferenced"),		\
+	C(DEREF_NEED_BRACE,	"Dereference needs a brace"),		\
+	C(DEREF_OPEN_BRACE,	"Dereference brace is not closed"),	\
+	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),	\
+	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),	\
+	C(DOUBLE_ARGS,		"$arg* can be used only once in the parameters"),	\
+	C(EVENT_EXIST,		"Given group/event name is already used by another event"),	\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),		\
+	C(EVENT_TOO_LONG,	"Event name is too long"),		\
+	C(FAIL_REG_PROBE,	"Failed to register probe event"),		\
+	C(FILE_NOT_FOUND,	"Failed to find the given file"),		\
+	C(FILE_ON_KPROBE,	"File offset is not available for kernel probes"),	\
+	C(GROUP_TOO_LONG,	"Group name is too long"),		\
+	C(IMMSTR_NO_CLOSE,	"String is not closed with '\"'"),		\
+	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
+	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),	\
+	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry or exit"),	\
+	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
+	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
+	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),	\
+	C(NOSUP_PERCPU,		"Per-cpu variable access is only for kernel probes"),	\
 	C(NO_ARG_BODY,		"No argument expression"),		\
-	C(BAD_INSN_BNDRY,	"Probe point is not an instruction boundary"),\
-	C(FAIL_REG_PROBE,	"Failed to register probe event"),\
-	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),\
-	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),\
-	C(SAME_PROBE,		"There is already the exact same probe event"),\
-	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
-	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
-	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
+	C(NO_ARG_NAME,		"Argument name is not specified"),		\
+	C(NO_BTFARG,		"This variable is not found at this probe point"),	\
+	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),		\
+	C(NO_BTF_FIELD,		"This field is not found."),		\
 	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
-	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
-	C(NO_BTFARG,		"This variable is not found at this probe point"),\
-	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),	\
-	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
-	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry or exit"),	\
-	C(DOUBLE_ARGS,		"$arg* can be used only once in the parameters"),	\
-	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),	\
-	C(ARGIDX_2BIG,		"$argN index is too big"),		\
+	C(NO_EVENT_FIELD,	"This event field is not found."),		\
+	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),	\
+	C(NO_EVENT_NAME,	"Event name is not specified"),		\
+	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(NO_PTR_STRCT,		"This is not a pointer to union/structure."),	\
-	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
-	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
-	C(NO_EVENT_FIELD,	"This event field is not found."),	\
-	C(NO_BTF_FIELD,		"This field is not found."),	\
-	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
-	C(BAD_TYPE4STR,		"This type does not fit for string."),\
-	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
-	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
+	C(NO_REGULAR_FILE,	"Not a regular file"),		\
+	C(NO_RETVAL,		"This function returns 'void' type"),		\
+	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
+	C(REFCNT_OPEN_BRACE,	"Reference counter brace is not closed"),	\
+	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
+	C(SAME_PROBE,		"There is already the exact same probe event"),	\
+	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
+	C(TOO_MANY_ARGS,	"Too many arguments are specified"),		\
 	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
-	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),  \
-	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"), \
+	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"),	\
+	C(TOO_MANY_OPS,		"Dereference is too much nested"),		\
+	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"),	\
+	C(TYPECAST_NOT_ALIGNED,	"Typecast field option is not byte-aligned"),	\
+	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"),	\
 	C(TYPECAST_REQ_FIELD,	"Typecast requires a field access"),	\
-	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"), \
-	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"), \
-	C(TYPECAST_NOT_ALIGNED,	"Typecast field option is not byte-aligned"), \
-	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"), \
-	C(NOSUP_PERCPU,		"Per-cpu variable access is only for kernel probes"),
+	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"),	\
+	C(USED_ARG_NAME,	"This argument name is already used"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

