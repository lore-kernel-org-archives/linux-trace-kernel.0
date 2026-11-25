Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586695;
	b=lJFIOZoPlWF/V+ePmOVLrglpe0HsCZtXuOWAeO5JkKuX/ouwZ3tq1WaJ2JnXEZFDyeXD
	 S4moOYQKrhzDehKBgWv8J/lSxJy7p3bxILk1MV68ysW1iF42DVWY1LkRzivYb7tRBp6se
	 nMPWPS0VGF5+QBk5Ij0tAw+xq7rNAx99czNCtA7M1ekjvl0NyIyGPsT8758NRPbhyx9bi
	 SBFSwIM9iPxVe7Asx7o4nzVlOZ7ynoAeJneq6PgUlGPYVJTj81FUHMSngtT1fTwUM2zTp
	 DXJXt+UEb9skycc69Ag6AJJPklkQsEeBa+OK6z0i/hFDtpOO8y9jYLJIfHUOBLVM/mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586695;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=66Ln1UYBWvi14zfQjJDJsFYE8g306UAJOEU3brcXK24=;
	b=vdMh44kJF+WORXk6jYPwGfdWTTBZuP99pmHD4f3GaUSu9sZDchmaZTeaKi4nsh5PVGHK
	 A075B9Ds4GItJI0Em1PES82mq6b+iaJKtXL3MJvnRownOcJNt7Rq5tar1oVJnwp83JgrJ
	 dbGgLSzuXMdwwGBjv+IQHGeRPc8dyYwnzoGjvS7FEyMqflCfg4UOHFyPWcoK7zLqnGSpx
	 i1cUQ3YHU6+W2PJoSizTeUkf+Bu6tHXVAgqLmS1ZPKCbnLXDnw0QePO1r4ZmEwqAIW1lW
	 1K9I++mfd3jG2G+GCs55JA/YlSq8dfSwADA1aGHDruD9yWifU8jqFhHKfFSy20fWVJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=rReCEkG5;
	arc=none smtp.remote-ip=79.135.106.105
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB52606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 06:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB52606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=rReCEkG5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1795586691; x=1795845891;
	bh=66Ln1UYBWvi14zfQjJDJsFYE8g306UAJOEU3brcXK24=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rReCEkG5FaBPXE0YsY6NkBct8TzuRrZtbN+HvdCUTRSDj0lmVCmYZvzsWmyJMSKoG
	 +Qz54nlwJ3pSlqUmnV/3XFCFNsWc+7kUeJqd/7x6H5odq2koX0qnVsp4QX5Kud4F3M
	 u8vhn+KspMSNYZ4BxHWB5Agxt/uCx+zm9v+6eZv+lufl87Y9I9LspC/ifYXxw21XlD
	 ew2WtN7kOd47iA8O21FqzNg6hflGOzwqCZxJvRKiWfeaoQID7BNmkXgfarqWgAwd06
	 NKAkEEUkSMZX+U/aEyNfqSlVCRE74kezntETBRG/S1WKcGVkRTDw3YxCdBQuqvnGjG
	 759vTIbJFUxYg==
Date: Wed, 25 Nov 2026 06:04:44 +0000
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Jaeyeong Lee <lee@jaeyeong.cc>, stable@vger.kernel.org
Subject: [PATCH] tracing: Reject filter commands in perf function event filters
Message-ID: <20261125060411.445-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 27638b4098703f9f3623c9852280c5ace016031b
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The perf function event (ftrace:function) keeps a CPU number in
event->ftrace_ops.private: perf_ftrace_function_register() stores
nr_cpu_ids there, and the TRACE_REG_PERF_ADD/DEL callbacks store
smp_processor_id() and nr_cpu_ids.

Since commit 31f505dc7033 ("ftrace: Implement :mod: cache filtering on
kernel command line"), ftrace_set_regex() treats ops->private as a
struct trace_array when the pattern contains a ":mod:" command. The
"ip" filter of a perf function event is passed unchanged to
ftrace_set_filter() and ftrace_set_notrace(), so a filter such as

  ip =3D=3D foo:mod:bar

makes ftrace_set_regex() use the CPU number as a trace_array pointer.
When the module is not loaded, ftrace_set_hash() sets
FTRACE_HASH_FL_MOD on the filter hash of the new perf event, which is
still NULL. If an earlier pattern in the same filter created the hash
(for example "ip =3D=3D vfs_read foo:mod:bar"), cache_mod() then
dereferences &tr->mod_trace at a small address instead:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  RIP: 0010:ftrace_set_hash+0x210/0x260
  Call Trace:
   ftrace_set_regex+0xc0/0x160
   ftrace_profile_set_filter+0x24f/0x340
   _perf_ioctl+0x531/0xb20
   perf_ioctl+0x42/0x70
   __x64_sys_ioctl+0x96/0xe0
   do_syscall_64+0xf9/0x540

  BUG: kernel NULL pointer dereference, address: 00000000000001f2
  RIP: 0010:cache_mod+0xb7/0x1f0
  Call Trace:
   ftrace_set_regex+0x121/0x160
   ftrace_profile_set_filter+0x24f/0x340
   _perf_ioctl+0x531/0xb20

Perf function filters only take function name patterns, and the perf
ops has no trace_array to cache module filters in. Reject patterns
that contain the ':' command separator before they reach
ftrace_set_regex(). This is the result ftrace_set_regex() already
returns for such patterns when ops->private is NULL.

Both crashes were reproduced on v7.4-rc4 (8d7fe9885c62) in QEMU/KVM
with x86_64_defconfig plus CONFIG_FUNCTION_TRACER, using a test that
opens ftrace:function with perf_event_open() and sets the filters above
with PERF_EVENT_IOC_SET_FILTER as root. With this change both filters
return -EINVAL without a crash, and plain filters such as
"ip =3D=3D vfs_read", "ip !=3D vfs_write" and
"ip =3D=3D vfs_read || ip =3D=3D vfs_write" are still accepted.

This bug was found by static analysis.

Fixes: 31f505dc7033 ("ftrace: Implement :mod: cache filtering on kernel com=
mand line")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 kernel/trace/trace_events_filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events=
_filter.c
index a9d77df3e..da48210a6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2669,6 +2669,9 @@ static int ftrace_function_set_regexp(struct ftrace_o=
ps *ops, int filter,
 {
 =09int ret;
=20
+=09if (strnchr(re, len, ':'))
+=09=09return -EINVAL;
+
 =09if (filter)
 =09=09ret =3D ftrace_set_filter(ops, re, len, reset);
 =09else
--=20
2.43.0


