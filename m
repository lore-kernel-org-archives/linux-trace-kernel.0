Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2338DC3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220769; cv=none; b=Fh1evMK+PpvhSGPJEWdpyM/MIPe6giQiMSFuL4WDMYds+CwThPTtOTZH0GArjpjeL+2auyAvMCgoUiI80mAs3b3vzGyHeLgHgIWUNn1LK5CFFMYchRpYPNva+502DMFRv1ZcIqQT7H9Kh5Rj160hlaj3gLBI8MXcy0WIxlBt4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220769; c=relaxed/simple;
	bh=XpVWj/YNsOye+4tpPPXTaUyU2lYlGgiftyYLiPSeSc0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pp5uN6b+M0qbYmhmWsJcZU3TbFaP1XoGQ9LDtEnjGhNGjm9SlKwU6jNukbeL2R90YeVFdZrQe3Q/PNI5Thrz5KjDROmFlpD+v1EskMRDdm6LROHmr245RTTdqMC60+EzJ7IJGg1Y4zRKYXEpDlP/+RcnMLwUJa8IwmD6sfqITFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YGafcSxt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YGafcSxt"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso9588728e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721220764; x=1721825564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHqPL0dVMHrEAXPenJABF+oC0XB3pqK0KrdcocNLCkY=;
        b=YGafcSxtd05OKZwwh6IcZFEehGIIqpDeFmsHrYWsCt0PaM4UCxdIO8ufEeDTQkgHLt
         EXbqM4L/nU13u2cYbC+c5SfvCZHMPFshEGGxS628Bm79HA7tSH3jmyVZouSkxbQpwduS
         te8YpScJjCchNirXGkoMBXSqSyvMcF+EuI3ga1OKYOx5YK4AubVxLCo2+CzbLJRqvKaK
         7dzR3BhWmriafy5tSCwSS/k7rUVU7IChp7E/ok+XRCgr3OuJjjIG4mHcIEzIxbIBNJKY
         AWNN2N/1n4QbbKJFMbNDo94CsrnrdVxSrv100MN9uQUb2CW3pAUAY+ZhT0ZmrUAio6S5
         AHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721220764; x=1721825564;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHqPL0dVMHrEAXPenJABF+oC0XB3pqK0KrdcocNLCkY=;
        b=W1VXTF8jjfes/uRB+04nWovCoJe0LBTdyJ1I8CCOD68h0xJxk+IbrJHSUXwqu3N4fI
         EQMC1SgsS3HCbCg0VWZVxhWuaiX2L9GovtxRSWhZ83nr2E0BKEK2wS8qom4nmtWQkqc3
         FVD5FZYxAsv7t8pqlXzOPtxq8XYV9d7PzE2ikmyr5qc28l6WHRhYaTCwJ4C3+U0wGvYN
         5mFaSnylonMgFgCz5EWov9rJaoX+kpp/ZR3HJaxmMm1pLWOSeqml3D/j7mtdPKwCYyt5
         kTe7tHkAZbZtBQLv1ECyQava03l5unWdHevUSh3FyZ5Z16oF95GYNIP2+pAYahZI5fbn
         S9oA==
X-Gm-Message-State: AOJu0YzNW8Y0TqJw6fEPIF4K+3emooT3dwCOWi1jlYvHYmV5DV11hLZi
	a9pfI+XsFn12kQaPzIM3uCYOucA6FeadkxCkxbLJWWR3puTWCMqOu2CrUlKMah7maMv1yyULtVC
	C
X-Google-Smtp-Source: AGHT+IGH0F61/HXszrNFVY1/ikCrpUc3bL430hYxVByFg7x/BWybxGNbAwqKuJptehsuhah+Bsp2pw==
X-Received: by 2002:a05:6512:1283:b0:52d:3ada:4b6b with SMTP id 2adb3069b0e04-52ee53a78e5mr1694695e87.1.1721220764341;
        Wed, 17 Jul 2024 05:52:44 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820f1fsm438828766b.219.2024.07.17.05.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 05:52:43 -0700 (PDT)
Message-ID: <92cff289-facb-4e42-b761-6fd2515d6018@suse.com>
Date: Wed, 17 Jul 2024 14:52:43 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH pre-6.7] kprobes: Fix double free of kretprobe_holder
To: linux-trace-kernel@vger.kernel.org
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Below is a patch for a kretprobe-related problem that was already fixed
in v6.7 as a side-effect of the objpool optimization, in commit
4bbd93455659 ("kprobes: kretprobe scalability improvement").

I'm sending it to the list because it might be useful to pick the fix up
for longterm or distribution kernels. Additionally, I would like to
propose a small improvement to refcount_t and this gives me an actual
problem to point to about its motivation.

Cheers,
Petr

---

From b0dde62cc5268a7d728cfdb360cb5170266a5e11 Mon Sep 17 00:00:00 2001
From: Petr Pavlu <petr.pavlu@suse.com>
Date: Thu, 4 Apr 2024 16:44:02 +0200
Subject: [PATCH pre-6.7] kprobes: Fix double free of kretprobe_holder

When unregistering a kretprobe, the code in unregister_kretprobes() sets
rp->rph->rp to NULL which forces all associated kretprobe_instances
still in use to be later freed separately via free_rp_inst_rcu().

Function unregister_kretprobes() then calls free_rp_inst() which takes
care of releasing all currently unused kretprobe_instances, the ones
that are on the kretprobe's freelist. The code in free_rp_inst() counts
a number of these released kretprobe_instances and invokes
refcount_sub_and_test(count, &rp->rph->ref) to decrease the
kretprobe_holder's refcount and subsequently calls kfree(rp->rph) if the
function returns true, indicating the refcount reached zero.

It is possible that the number of released kretprobe_instances in
free_rp_inst() is zero and therefore refcount_sub_and_test() is invoked
with count=0. Additionally, depending on timing, it can happen
that all previously used kretprobe_instances were already freed via
free_rp_inst_rcu(). This means the refcount of kretprobe_holder already
reached zero and was deallocated.

The resulting call of refcount_sub_and_test(0, &rp->rph->ref) in
free_rp_inst() is then a use-after-free. If the memory previously
occupied by the refcount is still set to zero then the call returns true
and kretprobe_holder gets wrongly freed for the second time.

Fix the problem by adding a check for count>0 before calling
refcount_sub_and_test() in free_rp_inst().

Note that this code was reworked in v6.7 by commit 4bbd93455659
("kprobes: kretprobe scalability improvement") and the new objpool
implementation doesn't have this problem.

Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/kprobes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0c6185aefaef..7ae5873545a1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1942,10 +1942,9 @@ static inline void free_rp_inst(struct kretprobe *rp)
 		count++;
 	}
 
-	if (refcount_sub_and_test(count, &rp->rph->ref)) {
+	if (count > 0 && refcount_sub_and_test(count, &rp->rph->ref))
 		kfree(rp->rph);
-		rp->rph = NULL;
-	}
+	rp->rph = NULL;
 }
 
 /* This assumes the 'tsk' is the current task or the is not running. */

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.35.3
