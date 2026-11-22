Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363036;
	b=FWODtDUILFAVNoL2SkgsU3VKHN6b0EeIkV60iEySaZ89Xr3UtkPaM6DuZXTDZTmwNJss
	 14+PaV3dNpP5cDL1fNgL+cU53LsEzetQV61VAoT5lkBe3GVMnphIoh1azfGw9QsWXyqKw
	 be8TEHpNc11s+gEqANF8GVs6b9GWx9dsofewgCWusQU5ZQ9NXBWeBnrW7dXULem8mKzGS
	 zlL9fYhQ3Zz8ywId7M2R/PZcdfzc9bneZdEz042/fUUsA6rPkiP48jg6WNktwxYLIj0Tz
	 /odVfk23OMboMu8VJmlwrhpe1Ei7lDvjQpvDjg2UQNVwOqaGO0ymRLuYvxCTFckU4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3H2feB3qOXa7No9DO3nPm/AqAsFqw7NNs3qbX/GBBBE=;
	b=XQJer5/WpCn9P89/RyNjSAH9lGKBLEiGWkt3VZdxEuITHupsQwj6RPcLNwSDARTOi2BA
	 fbH5wLGzyCx8jtq9Ae8afIgspThDeo/8lnB3Jny+fe0SUb23649UTH12Y2tiEMnJEC85m
	 OK1M831WuOjcjhvC4Lzau9CT8KS4K56s/10222v+QUNu/zghIa9Y4MUzpnLjPuRuKhTAP
	 kzRbxvpUoYvWV9xoFMyKln/FuhW3rSnPaD/RDBkFu8lHT42rrrdaqm03miieTZUXnN1gS
	 2+7l6fT685ERqe8NVFF1JW60eehkFgFqdEk7+JbAqBhEt0uthhOdSImWmNQOL6DjDGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0icwm26L;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E740606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E740606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0icwm26L
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a05b210703so1100119b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795363036; x=1795967836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3H2feB3qOXa7No9DO3nPm/AqAsFqw7NNs3qbX/GBBBE=;
        b=0icwm26LSvO90CYYrIVkbu8VhC9ejrd1KL+aJlMZuuvKNTHj6WsoF0phLGElvK+I07
         0OqRfoyXKQbr5k2KYxIIqDeB8OAbcm0HH9D+ZXM72HqYgD2zCoOmTOh2Y2vniTcWzABM
         S6mYjpvX0yl/tZgLphKqwM5TQ7obujjFtUYMf6l0ynOPTfLnL0ZJhWJjPwYTW35o8KB5
         vArAEwaxhIEeJOwNlzkni2OJ4z4MyTD0Af4c/fErYHbxivzmdYwDbFaWFSgqh7f/Zlvp
         nlcjIyGkiRjjpxSit0oPn7RI4FOuT1Y6TYzWz2Wh1pS6zNLVmHnuMXTUvvfMW5f8kBHO
         GMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795363036; x=1795967836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3H2feB3qOXa7No9DO3nPm/AqAsFqw7NNs3qbX/GBBBE=;
        b=y6781bv0C1W5ak4Wm2lUxTBylFZtNGwas8scvTVZyu/oJCPodsNETz7laYGs1kWKty
         cSmJVsVgsWjdGEluAOwf0y+cLkGGVVjuExYYB/vbqPX9p8LVVBVRJhPdADr+sEqUIic2
         C1/BxunIc+KdE+Mke5icm9P08CkCB+jHogqxvbT6Rtj2HqYPFwW2g3k+0A/LHoUw6JsC
         AQpU9d7vteNov5MH8Dy3gOwpdkNcMEwSkr3ghIKvURJcZSCf6A35/zw98cXMQ2T50rZX
         b2htKi9e+tZS3T2S/z/jo4wtCi1j36C/MG15TiMEGDBJ3RyGdSpSfO905dNc77Bdb5bY
         Ll2w==
X-Forwarded-Encrypted: i=1; AL+hErEEJi1J0+UJAeLP7MVhx54h8VZz+IIPRC54lTaiGDMzfCo/4zkfwimPAXTpNbmT2f7MmwUbthsOH++V4vD5xngqRCE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aSkuhHjPp3+3Jo21CgO4The7z9KptEWw+orRUO5bL4E+2JJL/
	ap0hPQc91Hi+Hfhulq3Y+Hgy8qL9OjeUFcQ4aY+6a0Huwls5vnw3lITD
X-Gm-Gg: AZFdTZfG5qsFNR0fN43gDikYBc9LI2rL1yPifhB4NU6EMhfQMAgziUxCyb1vOSvwzx2
	8kBcZiQAMK4sYTC7O5fYOAhcZfIKyY0lZvaOUHNUUHEfK9M/qMSKy38SEaJCIpUhPQUx0AtZrLl
	2Zlb476bH+mUp5PGUXYWdC5pdi2w6GyW0NLmVlBXpRKqUHq2qvwLgynMMmfbHHFko2baCtqIM02
	cN1HaiOiOq2Fm09bZBsUdP3zyZxP0TtvwO6Fzjy9Pj5W9tiwFTtCfO2Qu/H0PVvZSTImLbWOD1m
	sOj7YgT9rDR/z5aZs3BqS6JVQVpd95x8BZafgl2rnjXA1UD9tv97T/Nc6vGQzKLhBHYH2sO++Zs
	JKcEt+g6zWBCZGkonfDBZvtfHjpSlAzeMpOwSCCfPjCcTiVV6jTKDhzuc7072gXqbgcXbVRS25r
	GHlZxLzxYaXxq8Ag7d++7mLHb3laMspVTxexRnN4xQZuhjja0NgoeGYjrGIOJzliyy9321O1IY8
	5w5tOJsF5munTTF54hE51hcmLkq8B5IRzGt8sBpYRxoZzgSTPGP70nnU+ytoaVFpp9Udga1O9o6
	R5eahhwoYW7esiGYMeNsaaHMsk2DB2R07PR8lUq+im4KPZYbCjPX6MfgHCrexcsjJO6WTlXOO9j
	MHg==
X-Received: by 2002:a05:6a20:eec3:10b0:3e2:490d:5143 with SMTP id adf61e73a8af0-40148fc2d73mr5192607637.10.1795363035785;
        Sun, 22 Nov 2026 07:57:15 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm4192683b3a.1.2026.11.22.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:57:14 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	co+bba0c6b49150bef3@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] ftrace: Finish removing subops after a hash update failure
Date: Sun, 22 Nov 2026 07:56:20 -0800
Message-ID: <20261122155620.319722-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122155620.319722-1-bestswngs@gmail.com>
References: <20261122155620.319722-1-bestswngs@gmail.com>
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

Hi,

Here is the exact reproducer and the commands used for the crash in the
commit message.

The tested kernel was commit 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
with:

```
CONFIG_SMP=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_INLINE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FPROBE=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_FTRACE_STARTUP_TEST=y
CONFIG_EVENT_TRACE_STARTUP_TEST=y
```

KASAN and DEBUG_INFO produce and decode the report. FAILSLAB and its
stacktrace filter make the allocation failure deterministic. The reproducer
does not need a race or any kernel source modification. It must run as root
because it mounts tracefs and debugfs and configures failslab.

The test kernel also had the ftrace startup tests enabled. The `ftrace=nop`
command-line option below skips those boot-time tests; it does not disable
ftrace, and the reproducer selects the function_graph tracer itself. The
option is not required when the startup tests are disabled in the kernel
configuration.

Host command:

```
qemu-system-x86_64 \
    -accel kvm -cpu host -smp 4 -m 4096 \
    -no-reboot -nographic \
    -kernel arch/x86/boot/bzImage \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0 panic=1 oops=panic panic_on_warn=0 nokaslr net.ifnames=0 ftrace=nop"
```

The tested initramfs runs `/poc` from `/init`. To build and run it in an
existing guest instead:

```
gcc -O2 -Wall -Wextra -o poc poc.c
sudo ./poc
```

The reproducer does the following:

1. It enables the function_graph tracer with `tcp_v4_connect` as a nonempty
   filter.
2. It creates and enables a return fprobe on `udp_sendmsg`.
3. It scopes failslab to allocations below `ftrace_shutdown_subops()` and
   fails one allocation while disabling the fprobe. This makes
   `rebuild_hashes()` return -ENOMEM.
4. It updates the remaining graph filter, verifies that the fprobe operation
   is stuck with -EBUSY, and disables the function_graph tracer.
5. It enables the fprobe again. The stale SUBOP state sends the filter update
   through an empty manager list, and `ops_equal()` dereferences an
   uninitialized hash pointer.

With the command above, the failure was reproduced on the first run. The
relevant output was:

```
[*] removing subops B (fprobe) with rebuild_hashes() forced to -ENOMEM
FAULT_INJECTION: forcing a failure.
[*] updating the remaining graph filter after the failed teardown
[*] probing the bricked state (expect EBUSY + WARNs)
[-] write(/tmp/poctrace/events/fprobes/poc/enable, "1"): Device or resource busy
[!] CONFIRMED: fprobe_graph_ops is bricked (-EBUSY)
[*] removing subops A -> graph_ops->subop_list is now empty
[*] re-registering the fprobe: expect a wild deref in ops_equal()/ftrace_hash_empty()
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000802: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000000004017]
RIP: 0010:ops_equal+0x41/0x600
Call Trace:
 ftrace_update_ops+0x64/0x140
 ftrace_hash_move_and_update_subops.isra.0+0x180/0x360
 ftrace_hash_move_and_update_ops+0x271/0x350
 ftrace_set_hash+0x38e/0x860
 ftrace_set_filter_ips+0x88/0x270
 register_fprobe_ips+0x395/0x14d0
 register_fprobe+0x204/0x260
 enable_trace_fprobe+0x1ef/0x4b0
 fprobe_register+0xa3/0xd0
```

Complete PoC:

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <stdarg.h>

#define TR  "/tmp/poctrace"
#define FS  "/sys/kernel/debug/failslab"

static int kmsg_fd = -1;

static void say(const char *fmt, ...)
{
	char buf[512];
	va_list ap;
	int n;

	va_start(ap, fmt);
	n = vsnprintf(buf, sizeof(buf) - 1, fmt, ap);
	va_end(ap);
	if (n < 0)
		return;
	if (kmsg_fd >= 0)
		write(kmsg_fd, buf, n);
	else {
		fwrite(buf, 1, n, stdout);
		fflush(stdout);
	}
}

static int wr(const char *path, const char *val, int flags)
{
	int fd, n, e;

	fd = open(path, O_WRONLY | flags);
	if (fd < 0) {
		say("[-] open(%s): %s\n", path, strerror(errno));
		return -1;
	}
	n = write(fd, val, strlen(val));
	e = errno;
	close(fd);
	if (n < 0) {
		say("[-] write(%s, \"%s\"): %s\n", path, val, strerror(e));
		return -e;
	}
	return 0;
}

static int w(const char *path, const char *val)  { return wr(path, val, O_TRUNC); }
static int wa(const char *path, const char *val) { return wr(path, val, O_APPEND); }

static int wl(const char *path, unsigned long v)
{
	char buf[64];
	snprintf(buf, sizeof(buf), "%lu", v);
	return w(path, buf);
}

static int wx(const char *path, unsigned long v)
{
	char buf[64];
	snprintf(buf, sizeof(buf), "0x%lx", v);
	return w(path, buf);
}

static int sym_range(const char *name, unsigned long *start, unsigned long *end)
{
	FILE *f = fopen("/proc/kallsyms", "r");
	char line[512], nm[256], type;
	unsigned long addr;
	int found = 0;

	if (!f) {
		say("[-] /proc/kallsyms: %s\n", strerror(errno));
		return -1;
	}
	*start = *end = 0;
	while (fgets(line, sizeof(line), f)) {
		if (sscanf(line, "%lx %c %255s", &addr, &type, nm) != 3)
			continue;
		if (found) {
			if (addr > *start) {
				*end = addr;
				break;
			}
			continue;
		}
		if (!strcmp(nm, name)) {
			*start = addr;
			found = 1;
		}
	}
	fclose(f);
	if (!found)
		return -1;
	if (!*end)
		*end = *start + 0x400;
	return 0;
}

int main(void)
{
	unsigned long s = 0, e = 0;

	setvbuf(stdout, NULL, _IONBF, 0);
	kmsg_fd = open("/dev/kmsg", O_WRONLY);
	w("/proc/sys/kernel/printk_devkmsg", "on\n");
	w("/proc/sys/kernel/printk", "8 4 1 7");

	mkdir("/sys/kernel/debug", 0755);
	if (mount("none", "/sys/kernel/debug", "debugfs", 0, NULL) && errno != EBUSY)
		say("[-] mount debugfs: %s\n", strerror(errno));
	mkdir("/tmp", 0755);
	mkdir(TR, 0755);
	if (mount("none", TR, "tracefs", 0, NULL) && errno != EBUSY) {
		say("[-] mount tracefs: %s\n", strerror(errno));
		return 1;
	}

	if (sym_range("ftrace_shutdown_subops", &s, &e)) {
		say("[-] ftrace_shutdown_subops not in kallsyms\n");
		return 1;
	}
	say("[*] ftrace_shutdown_subops = [0x%lx, 0x%lx)\n", s, e);

	w(TR "/current_tracer", "nop");
	w(TR "/set_ftrace_filter", "tcp_v4_connect");
	if (w(TR "/current_tracer", "function_graph")) {
		say("[-] cannot enable function_graph\n");
		return 1;
	}

	wa(TR "/dynamic_events", "f:poc udp_sendmsg%return");
	if (w(TR "/events/fprobes/poc/enable", "1")) {
		say("[-] cannot enable the fprobe event\n");
		return 1;
	}

	w(FS "/times", "0");
	wl(FS "/probability", 0);
	wl(FS "/interval", 1);
	w(FS "/space", "0");
	wl(FS "/verbose", 2);
	w(FS "/task-filter", "N");
	w(FS "/ignore-gfp-wait", "N");
	wl(FS "/stacktrace-depth", 32);
	wx(FS "/require-start", s);
	wx(FS "/require-end", e);
	wl(FS "/probability", 100);
	w(FS "/times", "1");

	say("[*] removing subops B (fprobe) with rebuild_hashes() forced to -ENOMEM\n");
	w(TR "/events/fprobes/poc/enable", "0");

	wl(FS "/probability", 0);
	w(FS "/times", "0");
	wx(FS "/require-start", 0);
	wx(FS "/require-end", ~0UL);

	say("[*] updating the remaining graph filter after the failed teardown\n");
	if (w(TR "/set_ftrace_filter", "udp_sendmsg")) {
		say("[-] cannot update the remaining graph filter\n");
		return 1;
	}

	say("[*] probing the bricked state (expect EBUSY + WARNs)\n");
	{
		int r = w(TR "/events/fprobes/poc/enable", "1");
		if (r == -EBUSY)
			say("[!] CONFIRMED: fprobe_graph_ops is bricked (-EBUSY)\n");
		else
			say("[?] re-enable returned %d (expected -EBUSY=-16)\n", r);
		w(TR "/events/fprobes/poc/enable", "0");
	}

	say("[*] removing subops A -> graph_ops->subop_list is now empty\n");
	w(TR "/current_tracer", "nop");

	say("[*] re-registering the fprobe: expect a wild deref in "
	    "ops_equal()/ftrace_hash_empty()\n");
	w(TR "/events/fprobes/poc/enable", "1");

	say("[*] survived - no crash this round\n");
	w(TR "/events/fprobes/poc/enable", "0");
	wa(TR "/dynamic_events", "-:fprobes/poc");
	return 0;
}
```

Thanks,
Weiming
