Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF26199FAB;
	Thu,  4 Sep 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985834; cv=none; b=YIwJwZjmV4CJF9B4i/gY+CfLu0D5VryGTFCHQ7UGUWHiVPL1g8XTWr99RKin6v1uD3E6Cnd6JXA9nUytY1YWFyf3BeNg+kvB2UPnni7OSNziEUoSybpwyyxSKYe5Kq64HCo9MxSki+yONqwdmTfitjwRv6tt6KPJGnvSfAWvtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985834; c=relaxed/simple;
	bh=cR0kkQiOhOO+mVhWrGef3b5Ko/oMPdeUXKcuvtI9dCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OC8jCaj5a+WuJrslqR/oKzl6s+TFHsmSsFz01JGjcq6hKoOKbqilQeneyaGfnEIxG1pj/uO1IGihP1NtwBmy7eTWk/fMHrtXMhh5ppM1v8OUZ151JPt6eKvRKOjcRJB8BmTgrVtmZknQak0jhf10w6W7IRR+UYZYvamW8vN9v/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/w81wI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/w81wI7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ED14C4CEF4;
	Thu,  4 Sep 2025 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985833;
	bh=cR0kkQiOhOO+mVhWrGef3b5Ko/oMPdeUXKcuvtI9dCg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=B/w81wI7qXIsro9bibPxmg+ZtAiMrL6JcnGEZV8e0QPovfVifYbSiULHNf95UXjJc
	 KI9kURiacpcn62USXSS+TVSvf1rBh1AmpQv+nr5GEdCBzLRkGZEIEkxOH/r7fNuMB8
	 j+CBHqxVPwQKJ0ALAHopoqx7SuXM4CS7HM0AsOhbTBKEgr+MnU47w3aH72wIH0TrCO
	 g47RrUgEjtn+1G7Mxa9KWPfdtkzIGJ8QkzF5BVBrLobiWxDuAibKHwQCsiU9YTyVRq
	 te4vznFwU0gvOONAlunMPym9MGUsEult9OfAke32YJ5Qztj0qQJ9PvjC3lwFFz6WsQ
	 B/7nNU1okCG7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7670BCA1016;
	Thu,  4 Sep 2025 11:37:13 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Thu, 04 Sep 2025 13:36:52 +0200
Subject: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64
 clone_flags
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
X-B4-Tracking: v=1; b=H4sIANN5uWgC/x2NQQqDQAxFryJZGxitU7RXERcxRhuUsUwGWxDv3
 sHV48Hj/xNMoorBqzghyqGme8hSlQXwm8IiqFN2qF3tXecaTJFYMJGtGOR7c9YfMm3bSLwajpV
 vn4+GfTcR5JlPlBzcF/1wXX/dCTs2cgAAAA==
X-Change-ID: 20250904-trace-task-newtask-fix-callbacks-b158634c59da
To: Steven Rostedt <rostedt@goodmis.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 Simon Schuster <schuster.simon@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756985832; l=2094;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=csJ5txv6tqXJkqrIKhkf4TfiADTvCuVUIksSMgyFOQc=;
 b=38kU7qTU3ePme9DQA8Us2hLlr+NTH5vWQV+CBallDDv1+gLQMyaXqtUPGu2nQ1fcpi28/61XV
 ZZRnu69MyC5CqWYDz/cxbvX75QNMrlichdqEVJIep+QIIh6PWPsSZvz
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

From: Simon Schuster <schuster.simon@siemens-energy.com>

Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64 across
calltree") the task_newtask trace event exposes clone_flags as u64 to
its callbacks.

However, ltl_monitor was not adapted, resulting in a faulty callback.
This also resulted in an lkp build warning due to
-Wincompatible-pointer-types.

Fixes: edd3cb05c00a ("copy_process: pass clone_flags as u64 across calltree")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20250904113334.18822d43@canb.auug.org.au/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509040134.bQVbm7ja-lkp@intel.com/
Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
I did further search for other in-tree users of the task_newtask
callback, but the trace macros make it a bit harder. Yet, as far as I
could see, there are none, so this patch hopefully resolves the problem
for good. The other matches all relate to "tp_btf/task_newtask", which
seems to be unaffected.

With this patch, ARCH=S390 allmodconfig -- that originally tripped the
LKP builds -- now builds without further -Wincompatible-pointer-types
warnings.

Sorry for causing this trouble, and thanks to Stephen Rothwell for
testing/reporting.
---
 include/rv/ltl_monitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 67031a774e3d..5368cf5fd623 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -56,7 +56,7 @@ static void ltl_task_init(struct task_struct *task, bool task_creation)
 	ltl_atoms_fetch(task, mon);
 }
 
-static void handle_task_newtask(void *data, struct task_struct *task, unsigned long flags)
+static void handle_task_newtask(void *data, struct task_struct *task, u64 flags)
 {
 	ltl_task_init(task, true);
 }

---
base-commit: edd3cb05c00a040dc72bed20b14b5ba865188bce
change-id: 20250904-trace-task-newtask-fix-callbacks-b158634c59da

Best regards,
-- 
Simon Schuster <schuster.simon@siemens-energy.com>


