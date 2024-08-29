Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B31370;
	Thu, 29 Aug 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921477; cv=none; b=fxBxGKMJY5MJdvoo6fZpjj9cGxVroDN15NtZTa8hnp0mTdkucGUO9roZ6Bg2ZJytD55X6JtnsAwRMXGOtVF0sKtl0OIRafW9K3C/rpbDtasr8YymgzWXJB+uRvT2Yz2vLr3XU4vVSB2mZ4r79zT2qBpiPGbhy79uC9dKKKqS0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921477; c=relaxed/simple;
	bh=jhkOW35dlGl7U7jDzTXEVJDMWhEEG7w9ttZd2uRTMc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KxdowfnoF4xBFiJIvsN1DhRtT7+D0uYdfSe+mkeDKigrMWkiQjq4Vspw8quzkXc4xFOKE3k/wsQ9zrChGtx3ViemrryzVccbj+0asHVkKo4G3hTLKMLSmGbZSTH7NzwAl9CQ1meUJod4bx6kVYs8xLizys393k4IPuNpq7jibXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VXi/WQgG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VXi/WQgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Fi1Hg
	pc5bDqBUP91NhQHZLcWi/cOFy8RR+B2mPwpJKY=; b=VXi/WQgGt2kyU0TrAcBmc
	TTCkpimL7AuT3mj1r4TSJaK7apZhTFc7CITwqhC/h4s7NKRiXU72549WfpTR+Fze
	WlWLG2iKF20GGsMdO1k8RbNPtwl2lwwhD69VW9VwP8Fdw1HINhWuf4eeHhgVZicw
	R7w+CElRlHACKQzVNguxIA=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3f+dVNtBm+P8vAA--.5552S2;
	Thu, 29 Aug 2024 16:50:29 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2] eventfs: fix a null pointer access in eventfs_iterate
Date: Thu, 29 Aug 2024 16:50:25 +0800
Message-Id: <20240829085025.3600021-1-chizhiling@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+dVNtBm+P8vAA--.5552S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4rAryxAw43Xw15GF1ftFb_yoW7CFWUpr
	WUJr9xKw4xJw42qF12yr1qgr15Xr4kAa17Gr17AFy2k3WkZry3tFy7JFWjyrW3t3y5JryS
	gF1jkw1rtr1jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeoGQUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiTx5KnWXAno-TSAABso

From: Chi Zhiling <chizhiling@kylinos.cn>

We found a null pointer accessing in tracefs[1], the reason is that
the variable 'ei_child' is set to LIST_POISON1, that means the list
was removed in eventfs_remove_rec. so when access the ei_child->is_freed,
the panic triggered.

the linked list is protected by eventfs_mutex in eventfs_remove_rec,
so when we access the list of ei_child in eventfs_iterate, we also need
a mutex_lock in there to avoid eventfs_remove_rec modify the list.

by the way, the following script can reproduce this panic

loop1 (){
    while true
    do
        echo "p:kp submit_bio" > /sys/kernel/debug/tracing/kprobe_events
        echo "" > /sys/kernel/debug/tracing/kprobe_events
    done
}
loop2 (){
    while true
    do
        tree /sys/kernel/debug/tracing/events/kprobes/
    done
}
loop1 &
loop2

[1]:
[ 1147.959632][T17331] Unable to handle kernel paging request at virtual address dead000000000150
[ 1147.968239][T17331] Mem abort info:
[ 1147.971739][T17331]   ESR = 0x0000000096000004
[ 1147.976172][T17331]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1147.982171][T17331]   SET = 0, FnV = 0
[ 1147.985906][T17331]   EA = 0, S1PTW = 0
[ 1147.989734][T17331]   FSC = 0x04: level 0 translation fault
[ 1147.995292][T17331] Data abort info:
[ 1147.998858][T17331]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1148.005023][T17331]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1148.010759][T17331]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1148.016752][T17331] [dead000000000150] address between user and kernel address ranges
[ 1148.024571][T17331] Internal error: Oops: 0000000096000004 [#1] SMP
[ 1148.030825][T17331] Modules linked in: team_mode_loadbalance team nlmon act_gact cls_flower sch_ingress bonding tls macvlan dummy ib_core bridge stp llc veth amdgpu amdxcp mfd_core gpu_sched drm_exec drm_buddy radeon crct10dif_ce video drm_suballoc_helper ghash_ce drm_ttm_helper sha2_ce ttm sha256_arm64 i2c_algo_bit sha1_ce sbsa_gwdt cp210x drm_display_helper cec sr_mod cdrom drm_kms_helper binfmt_misc sg loop fuse drm dm_mod nfnetlink ip_tables autofs4 [last unloaded: tls]
[ 1148.072808][T17331] CPU: 3 PID: 17331 Comm: ls Tainted: G        W         ------- ----  6.6.43 #2
[ 1148.081751][T17331] Source Version: 21b3b386e948bedd29369af66f3e98ab01b1c650
[ 1148.088783][T17331] Hardware name: Greatwall GW-001M1A-FTF/GW-001M1A-FTF, BIOS KunLun BIOS V4.0 07/16/2020
[ 1148.098419][T17331] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1148.106060][T17331] pc : eventfs_iterate+0x2c0/0x398
[ 1148.111017][T17331] lr : eventfs_iterate+0x2fc/0x398
[ 1148.115969][T17331] sp : ffff80008d56bbd0
[ 1148.119964][T17331] x29: ffff80008d56bbf0 x28: ffff001ff5be2600 x27: 0000000000000000
[ 1148.127781][T17331] x26: ffff001ff52ca4e0 x25: 0000000000009977 x24: dead000000000100
[ 1148.135598][T17331] x23: 0000000000000000 x22: 000000000000000b x21: ffff800082645f10
[ 1148.143415][T17331] x20: ffff001fddf87c70 x19: ffff80008d56bc90 x18: 0000000000000000
[ 1148.151231][T17331] x17: 0000000000000000 x16: 0000000000000000 x15: ffff001ff52ca4e0
[ 1148.159048][T17331] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 1148.166864][T17331] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000804391d0
[ 1148.174680][T17331] x8 : 0000000180000000 x7 : 0000000000000018 x6 : 0000aaab04b92862
[ 1148.182498][T17331] x5 : 0000aaab04b92862 x4 : 0000000080000000 x3 : 0000000000000068
[ 1148.190314][T17331] x2 : 000000000000000f x1 : 0000000000007ea8 x0 : 0000000000000001
[ 1148.198131][T17331] Call trace:
[ 1148.201259][T17331]  eventfs_iterate+0x2c0/0x398
[ 1148.205864][T17331]  iterate_dir+0x98/0x188
[ 1148.210036][T17331]  __arm64_sys_getdents64+0x78/0x160
[ 1148.215161][T17331]  invoke_syscall+0x78/0x108
[ 1148.219593][T17331]  el0_svc_common.constprop.0+0x48/0xf0
[ 1148.224977][T17331]  do_el0_svc+0x24/0x38
[ 1148.228974][T17331]  el0_svc+0x40/0x168
[ 1148.232798][T17331]  el0t_64_sync_handler+0x120/0x130
[ 1148.237836][T17331]  el0t_64_sync+0x1a4/0x1a8
[ 1148.242182][T17331] Code: 54ffff6c f9400676 910006d6 f9000676 (b9405300)
[ 1148.248955][T17331] ---[ end trace 0000000000000000 ]---

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/tracefs/event_inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 01e99e98457d..18aae67704dc 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -642,6 +642,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	/* Subtract the skipped entries above */
 	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
 
+	mutex_lock(&eventfs_mutex);
+	if (ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		goto out;
+	}
+
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 
@@ -659,9 +665,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		ino = eventfs_dir_ino(ei_child);
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
+			mutex_unlock(&eventfs_mutex);
 			goto out_dec;
+		}
 	}
+	mutex_unlock(&eventfs_mutex);
 	ret = 1;
  out:
 	srcu_read_unlock(&eventfs_srcu, idx);
-- 
2.27.0

