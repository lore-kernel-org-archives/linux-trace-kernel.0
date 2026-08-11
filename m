Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECC26A1CF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407810; cv=none; b=Vdg4Pd/ZR8cB46vJeRJW5NVpgHDdbOw+FtUUj7hJH/BAn9Snc5Rxtf3azbxgqi3oM9t+YGAWWL+OGZ1EK24K89geqIAh741+JLHE2yggWSMAPz6pHWD6OztcNZUNLM3rmVsGsAfPEiaq7M8eb526PyrdycXlg5pp7K8Oi6GP4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407810; c=relaxed/simple;
	bh=6tbz341A6ghJ5hA79iptT3mScHiMusxbo++agf3YAxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kWJoayxEWukGOa7MpoOV+4kwX4Zo+ac1lWQGpevze2kktrvcabuRA+dalxqthiuFGD/fBbe5bP481557oEyHkw6GSUqPO6MdEGErM3SxFJ/rwHWC8G2A2OmZKTindg2vpe2MHNpwFsRW9bPxsufXU4UlWNYC6klXqW8NDbGg+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6ae934cbe4fso1720834eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 17:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407808; x=1787012608;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h44+2s/Ph52RNeWd5HsP6bCA6AoJMRrsddgmuJLyNms=;
        b=JO5LrYRiWEwrkp2tU0J0qCvyDplxCZsEFpzfRFYAipijlJms0s0LRb7Kgz0iqfhUs2
         UAc0UJ48/MXonp5EvL0NdskomWFxxe8PfuZgpqoP9Aq5r1nk5uOcwIGulTRJCJN4/vcM
         P0WrFeLTsI1eMmbTv8KdKB3vCv3zlTt8rNpU+eUUGlQoSig5RI3X5ckQjw3P7vCpJu/L
         V7usTVvRpBNHALSMHpfBCxMYIAoNCI9FN049AfzAoBmEEjcH3I+zPhq+NScw6oNSnm1b
         r2bgWWiPI8CrYEs9CiwQpO1Yy3RyRojqMkNWEj0AzpGxUBy/mEn6yD4lSPeOtaBAz+OL
         7hxA==
X-Forwarded-Encrypted: i=1; AHgh+RrCpzRmvVQZt4bwnyH5nsV/zmlD9rG3/7p+iL5D+OX5ge1volxUat9s3CFkOLVDSJK3TIvjbEmJAjfHgee+a8QKhGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rAjtQCX1u8YdZxCRkiKECeVVmOTfHiwiDNk+JWrv+3df9idA
	8VYCKrAymz8SRsEgnn7iqEuXVAF7rKm//9j+X5olXqXOgbifJd6J2P7D1isPNDlpWidyOFDk9aJ
	mE1nhVoiu3rYDzSEG+Po7X+5+0os//NNRAHE6CcU2JfOS6kLEIxHRtELFUP4=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1791:b0:6b0:3572:38b1 with SMTP id
 006d021491bc7-6b090589087mr3187100eaf.13.1786407807887; Mon, 10 Aug 2026
 17:23:27 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:23:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com>
Subject: [syzbot] [trace?] BUG: unable to handle kernel paging request in __ftrace_set_clr_event_nolock
From: syzbot <syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    ba5cc80fd326 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D10a75079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4d3143c8e28f6266c=
636
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/959ad5f4e730/disk-=
ba5cc80f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0787d25f251e/vmlinux-=
ba5cc80f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e85c36fabac/Ima=
ge-ba5cc80f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000000
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Mem abort info:
  ESR =3D 0x0000000096000005
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x05: level 1 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0
[dfff800000000000] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Instance 9=EF=BF=BDG=1E=EF=BF=BD=CC=8C83=EF=BF=BD=EF=BF=BDs]t4	=EF=BF=BD=EF=
=BF=BD=C4=B6y=EF=BF=BDG=18|aJ=EF=BF=BD =EF=BF=BD=EF=BF=BDVF=EF=BF=BD=EF=BF=
=BD8V$m=EF=BF=BD=EF=BF=BD7To0FO=EF=BF=BDP=EF=BF=BDp=1E=EF=BF=BD=EF=BF=BD6=
=EF=BF=BDO=0C%=EF=BF=BD=C7=B1=EF=BF=BDrf0 not found
Modules linked in:
CPU: 1 UID: 0 PID: 15930 Comm: syz.7.4873 Tainted: G             L      syz=
kaller #0 PREEMPT=20
Tainted: [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/02/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
pc : strcmp+0x28/0xf0 lib/string.c:265
lr : remove_cache_mod kernel/trace/trace_events.c:948 [inline]
lr : cache_mod kernel/trace/trace_events.c:977 [inline]
lr : __ftrace_set_clr_event_nolock+0x6a0/0x940 kernel/trace/trace_events.c:=
1395
sp : ffff800093567840
x29: ffff800093567870 x28: dfff800000000000 x27: 0000000000000000
x26: ffff800088d6e8b0 x25: ffff0000c71e0580 x24: 00000000ffffffea
x23: ffff800088d6e8b0 x22: 0000000000000000 x21: dfff800000000000
x20: ffff0000c71e0598 x19: ffff0000d4e7e4a0 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: dfff800000000000 x9 : ffff0000d2e90f01
x8 : 0000000000000000 x7 : ffff800080538ea0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000806c6790
x2 : 0000000000000000 x1 : ffff0000d2e90f01 x0 : 0000000000000000
Call trace:
 strcmp+0x28/0xf0 lib/string.c:265 (P)
 remove_cache_mod kernel/trace/trace_events.c:948 [inline]
 cache_mod kernel/trace/trace_events.c:977 [inline]
 __ftrace_set_clr_event_nolock+0x6a0/0x940 kernel/trace/trace_events.c:1395
 __ftrace_set_clr_event+0xa8/0xec kernel/trace/trace_events.c:1410
 ftrace_set_clr_event+0x2a0/0x438 kernel/trace/trace_events.c:1460
 ftrace_event_write+0x1dc/0x28c kernel/trace/trace_events.c:1548
 vfs_write+0x2a4/0xa0c fs/read_write.c:685
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:738
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:757
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
Code: aa0103e9 f2fbffea d343fc0b 1200080c (38ea696b)=20
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0103e9 	mov	x9, x1
   4:	f2fbffea 	movk	x10, #0xdfff, lsl #48
   8:	d343fc0b 	lsr	x11, x0, #3
   c:	1200080c 	and	w12, w0, #0x7
* 10:	38ea696b 	ldrsb	w11, [x11, x10] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
