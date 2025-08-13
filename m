Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675E1DFCB;
	Wed, 13 Aug 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052270; cv=none; b=O2QHNTqPLW5pUOe9jb2SP2V85F1vhImaXy/gYIVwKE4zXCYmDGQks0TdJr3yD/ituUtnVSIe3H/EvlzCiGbC8zKIQdz+x23tCUiMnAdynNvuhduur81PcPkhzoRrgarx4Vn3MRyAJQPuMOg+e6YXf+Kk/LdkEDVEnn48cl+WZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052270; c=relaxed/simple;
	bh=hU/0TH7lghHl6t4MYNWRG2aMIC8IpV+/9OJ9RsblgLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwmDHgW4VTwb7ftppRAob+tPYaeTCM11zfJ4KBdoSDUSPj7WFEfE1UWOWGNGDXtutzer+mT3OZQYq6i4CotsUvxsfSstUFMS2OjaPeWGznzknvRJd7QJhTrRagijXoZ+7N7LxljVY2EfD8C4wSGCvFdVK9Lqw9K5tZuTfuWbRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1sn66GxHzKHMlM;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 256AB1A1CD5;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCXExTn+JtoJBUADg--.30982S3;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next 1/2] ftrace: Remove unnecessary free_ftrace_hash in ftrace_regex_open
Date: Wed, 13 Aug 2025 02:30:43 +0000
Message-Id: <20250813023044.2121943-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813023044.2121943-1-wutengda@huaweicloud.com>
References: <20250813023044.2121943-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExTn+JtoJBUADg--.30982S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4xGw1DJFyUGFyUurW7urg_yoW5JFW3pF
	WSyr1DGrWUAF4kKr1j9F18tr17Gws0yFy8Was2qryYvrnxXw1jvasFvryDXwsxCry3Kay3
	WF1Iv3WUKr1Yq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhvttUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When reading set_ftrace_{notrace,filter} files, the ftrace_regex_open()
function incorrectly frees iter->hash when seq_open fails. This is
problematic because iter->hash points to the global {notrace,filter}_hash,
and the reading process freeing it would cause errors when other processes
access this memory.

The specific scenario occurs when:
1. {notrace,filter}_hash gets freed by a reader
2. Another process attempts to append something to the file
3. alloc_and_copy_ftrace_hash() tries to duplicate the freed {notrace,filter}_hash
4. A use-after-free (UAF) occurs

[  146.788584] BUG: KASAN: slab-use-after-free in alloc_and_copy_ftrace_hash+0x4b4/0x4c0
[  146.790278] Read of size 8 at addr ffff88810fa20818 by task bash/163
[  146.791254]
[  146.792776] CPU: 3 UID: 0 PID: 163 Comm: bash Not tainted 6.16.0-next-20250808+ #13 PREEMPT(full)
[  146.793243] Call Trace:
[  146.793393]  <TASK>
[  146.793572]  dump_stack_lvl+0x55/0x70
[  146.793729]  print_report+0xcb/0x610
[  146.793777]  ? __virt_addr_valid+0x1e8/0x2e0
[  146.793818]  ? alloc_and_copy_ftrace_hash+0x4b4/0x4c0
[  146.793852]  kasan_report+0xb8/0xf0
[  146.793886]  ? alloc_and_copy_ftrace_hash+0x4b4/0x4c0
[  146.793928]  alloc_and_copy_ftrace_hash+0x4b4/0x4c0
[  146.793964]  ? mutex_lock+0x90/0xe0
[  146.794002]  ftrace_regex_open+0x61f/0xc80
[  146.794182]  do_dentry_open+0x44f/0x1110
[  146.794369]  vfs_open+0x79/0x350
[  146.794412]  path_openat+0x13fb/0x3ec0
[  146.794662]  do_filp_open+0x1d7/0x420
[  146.794874]  do_sys_openat2+0xd4/0x160
[  146.794976]  __x64_sys_openat+0x122/0x1e0
[  146.795078]  do_syscall_64+0x4d/0x1d0
[  146.795112]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The free_ftrace_hash call is just unnecessary in this context since
we shouldn't free the global hash that we don't own. Remove this call
to fix the issue.

Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..cade13595b08 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4680,7 +4680,6 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 			m->private = iter;
 		} else {
 			/* Failed */
-			free_ftrace_hash(iter->hash);
 			trace_parser_put(&iter->parser);
 		}
 	} else
-- 
2.34.1

