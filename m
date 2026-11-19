Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057191;
	b=B7oISNkaiCXsAeR6BBFGR0FPaYWN48E2Ntj2TdcWNiX51wlZNS2TnpltiJW8js5Wzlee
	 Pu/LNf3TMoqDo6oJg1rXroCt6Pl1mwz+5dv9RsLlAnbv8+lvwDdAZXCC49qg9c4Ls8xOa
	 iQ7XoTznmM8X63aw5Y86l2oTPxCVkapBzt08Lol09chuVdARirx51b5hN4zZGlca17mHF
	 /xmtyeT4KePazUaA6pm19xGEd/GxKOvzYucttZ+Jqv3Bj28dgC/yFCrTgQDXfTV6O5Sei
	 F4om4cuwaostjAv73/2v3FnN5nWMQfB5Bs6koAlGBpz2A2kYD8RC084QM38OGLpyfkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BemN4KAEIv94JTaM/LB9CfX7xPFFKwFGGLfkDjDGM5Q=;
	b=Puv9bahOhOQA5zd9IHdnpDnqTJxsA93vm1cXuwLeMPw5/fmxFfFoK2krQ7Dq9IyioXei
	 86iKFT6IzWCz6vkxTDiFNdirC6ZJWpk841OBq1gudZpoIMbvk0rXTrW47GS6+yz7Tefnq
	 gxRKNGfa/P0Ya9WT/2Qocz0+mjc0Zp5weRAw2cL3T/NCuBaxw9ufxy5DfogPy2Z44i56R
	 9+9D3P/wm9Jn/hiVDcVnzzcQprTxO8Fgz+TkwHarP6JqsEx3oEor8O9rN64Mpb7hzpUOW
	 PMsi7s1L2rlHYqESWTx7PySUwL03J4pSzCw7/p7srMiYK/torcMod0i5nLxASN8Ad7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUwIT1Vg;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAA606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 02:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AAAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUwIT1Vg
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-381f65e4e4bso2777044eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057190; x=1795661990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BemN4KAEIv94JTaM/LB9CfX7xPFFKwFGGLfkDjDGM5Q=;
        b=vUwIT1VgurTA5PcH58CV+OidjaQlZarrpDkxokT5Dc2FKUvEj1pnfPS32bbDNcWXOI
         iS7TSFfQuJszS1B/dTp2aGKTksWm1ccF7NBWe8lXiANy+kQGZqppOBJQkkvXLqHddlz7
         Z4mCYbXH/JPRElL7Qy5Zlgy3IQABFFNg90T0B9+tmiXAQqRc6Uo8kR2rMXxdHIM4sVLX
         dASfsJFLI2rMl3+D0xOmaQ17kXymY53zTt17yYv2R+gDZUBsekaZ/W+po1ydfdaEYZOb
         5ZeozYdnX+OMDnyYLCSuvB2clE5P4cp87sv7dwEy1QBvFPJMRTa/EarhKESF/D/jnC0I
         b9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057190; x=1795661990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BemN4KAEIv94JTaM/LB9CfX7xPFFKwFGGLfkDjDGM5Q=;
        b=aaLNku0k7DfI1u9vr1wSLmgyjsDMbUJPaGFR08nz/WryxyEaRxdgUjWSNn+gQXwbzR
         uxC58cbjzI8GNG5p+sRCIM41tkQX183BNg/V/rx0nfUxyPkd81V7ZQFui822oPlzidjJ
         dpVPcOjj/5zVTYn1nETAN7VqDxku2PBfeIkuD0Tlp9H0SjtPp6s8Mzb8ZU5Opx8yBPRY
         ZRG0edhFYjsvMKT8jSvB2dBnnXF7DPJaWx067yz6boW8TMfW3w1Ajy+LuZBK5mlvqSot
         cJULLwY+BZzRxW3g7p8Vgm7vAUjKbRLUy8My7qPAdP/CwYEOc+WOOKHQGcaslzLWlWeU
         hB5A==
X-Forwarded-Encrypted: i=1; AL+hErEpCFxuX1/hQ1fivVIzKG3st/tSPPYDkTjzwSwreatr4dEAgpJJvhW9KywjnTGz+1emblDGdXKSp5qAZNHL//8CrAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rX4MDpVuUMh6isjdix1zJ17v/1xlBwIp1Ab8UQWI7IdsZukmV
	ZUFNH1DIf2s7mmVln+Cb8MWr1DQRuFybKbFa1pMFd2jvClOv5aZ2UqCfHhZOEeXEVqU=
X-Gm-Gg: AZFdTZd6L9fYvBgzBgmcPGoXzghuYeLUtjK9ABcMh04hRx2vC/iJ9Zw18bToSB3fEMD
	Gc8E/5Uti7HCqkXIdMvd9AupXZrHfN/BGh1Z3OBLtMdDTNEsnryaYICtjnfN1rC04mKinaRz+Gx
	BuCydnss5frWaMtfAwh6vDfbI2+14sYxA0kE4UuhZfFgN0Gu3wJ3Y1i+xlnWD8+kN9QM5O7g8dz
	AI7Ju2xbVT84eS+IgLM4ZcPf4KSv9GCnjgk3iyjgyhjW9OSb03yBNsbd34OssIBv+q9HOZIWojM
	Hnb7e/js21m5AFI0Tx0B0jpK/U7sgFf2g2QC4PObymyA8vHcQZvlT41fwq6IcAdgWU9iKcuOv40
	QTB9OvQbti18YuXI5VX46jF4CUXZ/SOT0Kmu+lvdysJRFW2UvNeqn7Si0GQvUG++CcvmDbRhrei
	P+pPQ6Q86IEcSlvbW9lAlksOB/Hu4u10vKuMe2iKHZ39AP+u6DJFlyFAC72w8II4sxYgqwEE7Cd
	35TgscWE/bCZpL6ovb9c0wW8MAvumVETayrLGByOxd0uuh9uIZnenzAXCE9FI97p6Irl3VKfIPK
	FWUcIO3tgQVZ/jmtHONmtnUWWsMzw/0X1iH2C/6Hqa/GoQkW+b+1NpGW3AjjmKBPj1U4aXZi181
	8Fg==
X-Received: by 2002:a05:693c:2805:b0:36c:a1ef:f8f7 with SMTP id 5a478bee46e88-3827dd05b5emr4256126eec.4.1795057189615;
        Wed, 18 Nov 2026 18:59:49 -0800 (PST)
Received: from Desktop ([182.161.246.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm19658301eec.9.2026.11.18.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:59:48 -0800 (PST)
From: JunYoung Lee <ljyoung04@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Require kallsyms permission for the .function filter modifier
Date: Thu, 19 Nov 2026 11:59:41 +0900
Message-ID: <20261119025941.87102-1-ljyoung04@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven, Masami,

An unprivileged user can locate the kernel image (KASLR bypass) with
PERF_EVENT_IOC_SET_FILTER at the default perf_event_paranoid=2.
parse_pred() accepts "<field>.function == <addr>" only if the address
resolves in kallsyms, and the perf path has no permission check, so the
ioctl result tells whether an address is kernel text. The details and
the fix are in the patch below.

Affected (reproduced as uid 65534, KASLR on), since e6745a4da964 (v6.3):
- mainline 4405c18c95d2 (v7.4-rc3-230)
- stable 6.12.118

Example on mainline: a counting event on ftrace:print (field "ip") and
561 probes return image_start=0xffffffffa1000000 and
image_end=0xffffffffaae30000. These equal _stext and _end in
/proc/kallsyms as read by root; the same user sees zeros there. No
tracefs and no capabilities are needed. Not affected:
perf_event_paranoid > 2, or perf_event_open blocked.

A C reproducer is available privately on request.

Testing of the patch on mainline with KASAN: for an unprivileged user
every .function form now fails with -EINVAL, and ordinary filters still
work. Root keeps .function via perf and tracefs (it is refused under
kptr_restrict=2, like kallsyms values). ftrace selftests test.d/filter
pass 4/4. checkpatch --strict and W=1 are clean. A 6.12.y backport is
available.

A separate issue seen while testing: as root, a .function filter on the
perf function event (ftrace:function) crashes the kernel with a NULL
dereference in ftrace_function_set_filter_pred(), because pred->regex
is not set on the .function path. It needs CAP_PERFMON. I can send
details if useful.

Found with AI-assisted code analysis. All results come from test runs.

Thanks,
JunYoung Lee

-- >8 --
"<field>.function == <operand>" resolves the operand to a kernel symbol
range. parse_pred() accepts the predicate only if
kallsyms_lookup_size_offset() succeeds, so the result of setting the
filter tells whether an address lies inside the kernel image (or a
module).

perf_event_open() allows any user to open a tracepoint event for
counting at the default perf_event_paranoid=2, and
PERF_EVENT_IOC_SET_FILTER passes the string to the same parser without
a permission check. An unprivileged user can therefore probe addresses
one ioctl at a time and recover _stext and _end exactly (about 560
ioctls on x86-64, under two seconds), while /proc/kallsyms shows that
user zeros.

Apply the rule that /proc/kallsyms uses, kallsyms_show_value() on the
current credentials, before the operand is looked at, so both the
numeric and the symbol name form are refused to callers who may not
see kernel addresses. Root and CAP_SYSLOG keep the modifier under the
default kptr_restrict. With kptr_restrict=2 it is refused to everyone,
the same as kallsyms values are hidden from everyone.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Signed-off-by: JunYoung Lee <ljyoung04@gmail.com>
---
 kernel/trace/trace_events_filter.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..895ef6d7652a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -118,6 +118,7 @@ struct filter_pred {
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
 	C(NO_FUNCTION,		"Function not found"),			\
+	C(FUNCTION_PERM,	"Not permitted to filter on kernel addresses"), \
 	C(GLOB_WITHIN,		"'within' filter cannot take glob expressions"), \
 	C(ERRNO,		"Error"),				\
 	C(NO_FILTER,		"No filter found")
@@ -1743,6 +1744,16 @@ static int parse_pred(const char *str, void *data,
 	pred->op = op;
 
 	if (function) {
+		/*
+		 * Whether the operand is accepted, and which events then
+		 * match, tells where kernel text is. perf lets unprivileged
+		 * users set filters, so apply the /proc/kallsyms rule.
+		 */
+		if (!kallsyms_show_value(current_cred())) {
+			parse_error(pe, FILT_ERR_FUNCTION_PERM, pos + i);
+			goto err_free;
+		}
+
 		/* The field must be the same size as long */
 		if (field->size != sizeof(long)) {
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
