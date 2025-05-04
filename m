Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82772260C;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383320; cv=none; b=H/9mBVyn2N8TbQM7WIQy+uzFJaYSVN97BZS8m4DR3B29BXv3hrRv5OsB9aSdVc36mEiS7ggNExDCcPGMqNU+T+nVYPA06OhTJPTSKVpfySp7CIGftXLKdnSabmXxumqrwu+OQSg3oFSrMU9cJYoDF1fHyLahy6+ZTqUhxMfVsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383320; c=relaxed/simple;
	bh=BIeAtAmNY2HmAC4pfdofUHiWDpOKu8mzigM6HzNEzFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZU7xK/s34t/9NvIhcX7Bbof2hQbELX3Djrmk5u0YVEIM+EXO4/C9y3PyNXV3TCmM1K/xeUhmdZL5wCosaMPjUCQdHlCtvYg+9F/awlwWYoKqMHmNtvt32NRHgXkpTqtubP4iBPH6ouB2f7G7J8h0NaygwceODGnPXiOuyCVIW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD6oVOaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD6oVOaY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 796FEC4CEE7;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746383320;
	bh=BIeAtAmNY2HmAC4pfdofUHiWDpOKu8mzigM6HzNEzFo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KD6oVOaYYMYWvKheiXyOZk9M8Y9srgfr1xKoXizDfnBI7LlhsjhZgeqiIPZZ3/LL8
	 KZgHF9EaCOAUZgkygo/Bsg5aTSCNs7jYigtXMeQt7PmYxc+4t0Cot5RW97cR3xIeOe
	 Ns0AnbVNCw74Rmnzefv+rwBaSdr21RjhXhb3kAzrcFpJcVABZRpHpo6cBlEb+X7iMY
	 jl0MLdTqVTSBrtJ8KSdj//7N6juusyqbr3qndlmT2f9qccEW5n1IK955eqh3eXqSbT
	 xTIBu889j6aYqYdC6uvCIlB5AB0FrhI+Y69FjEKWvxxt3oe/VRWtvt5gm00Lo0n4yD
	 U0I1WzY9GdOFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68523C369DC;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
From: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] tracing: fix race when creating trace probe log
 error message
Date: Sun, 04 May 2025 20:27:51 +0200
Message-Id: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKexF2gC/33NwQrCMAyA4VcZPRtp44rTk+8hHro0boVtHe0oy
 ti72w1EL3oqf0i+ziJycBzFuZhF4OSi80OOw64Q1JqhYXA2t0CJWpYo4e4eMAVDDGPwNUPnG9i
 SqDrZivW9Vlrk8zFw3t3o6y136+Lkw3P7Kal1+kbxN5oUKLB4xMqWSIbqS9Mb1+3J92JFE34gL
 f9BCBK0UkykNObnG1qW5QXIPi82CQEAAA==
X-Change-ID: 20250420-fix-trace-probe-log-race-cc89d8e5fb15
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Paul Cacheux <paulcacheux@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746383319; l=1945;
 i=paulcacheux@gmail.com; s=20250422; h=from:subject:message-id;
 bh=BIeAtAmNY2HmAC4pfdofUHiWDpOKu8mzigM6HzNEzFo=;
 b=xGxrPxvCphgAewDOXLHC8XN7I8v1vK7/vyUTeb9HpH5EMpsKRzLIhG6xiTsmujyg6xBBQPu1w
 a3NjLOFgooyCAkeADwReTtAI8DNscn4hm02jRhxdBxZSzmhbEB0L+h1
X-Developer-Key: i=paulcacheux@gmail.com; a=ed25519;
 pk=8UguSecyECHKHp0YLS7hTEDob0ctFMr3ygBTeAmrFHs=
X-Endpoint-Received: by B4 Relay for paulcacheux@gmail.com/20250422 with
 auth_id=386
X-Original-From: Paul Cacheux <paulcacheux@gmail.com>
Reply-To: paulcacheux@gmail.com

Hello,

As reported in [1] a race exists in the shared trace probe log
used to build error messages. This can cause kernel crashes
when building the actual error message, but the race happens
even for non-error tracefs uses, it's just not visible.

Reproducer first reported that is still crashing:

  # 'p4' is invalid command which make kernel run into trace_probe_log_err()
  cd /sys/kernel/debug/tracing
  while true; do
    echo 'p4:myprobe1 do_sys_openat2 dfd=%ax filename=%dx flags=%cx mode=+4($stack)' >> kprobe_events &
    echo 'p4:myprobe2 do_sys_openat2' >> kprobe_events &
    echo 'p4:myprobe3 do_sys_openat2 dfd=%ax filename=%dx' >> kprobe_events &
  done;

The original email suggested to use a mutex or to allocate the
trace_probe_log on the stack. This patch implements a simpler
solution suggest during the review of the v1 where we only protect
access to the shared trace_probe_log with a mutex. This will prevent
any crash from happening.

[1] https://lore.kernel.org/all/20221121081103.3070449-1-zhengyejian1@huawei.com/T/

Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
---
Changes in v3:
- add some comment around the new mutex definition
- Link to v2: https://lore.kernel.org/r/20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com

Changes in v2:
- change approach, and use the mutex based solution suggested during
  review
- Link to v1: https://lore.kernel.org/r/20250422-fix-trace-probe-log-race-v1-1-d2728d42cacb@gmail.com

---
Paul Cacheux (2):
      tracing: add missing trace_probe_log_clear for eprobes
      tracing: protect trace_probe_log with mutex

 kernel/trace/trace_eprobe.c |  3 +++
 kernel/trace/trace_probe.c  | 13 +++++++++++++
 2 files changed, 16 insertions(+)
---
base-commit: 95d3481af6dc90fd7175a7643fd108cdcb808ce5
change-id: 20250420-fix-trace-probe-log-race-cc89d8e5fb15

Best regards,
-- 
Paul Cacheux <paulcacheux@gmail.com>


