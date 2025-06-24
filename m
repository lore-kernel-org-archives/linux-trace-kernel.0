Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CC24678F;
	Tue, 24 Jun 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747957; cv=none; b=FLR9a63itHdQKngteciq3dI6EBCagEMAfoQLc2wtf/aRaFD2lHiKuV9qwojvCQnBPKHCXUNsa58auSle3MTnx5kfF64y1JGdNoFKgQmQGRjF4l2+N6gTNK/r4i8dQhvyAppqvg9qhGWd0O+kuPfxNcrel7HA3gml9XvG7LpgHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747957; c=relaxed/simple;
	bh=IwtqpUUs2GAjRDgMrffiPNG04xDpRsc/RMX91PflDTM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Q4sg7k5ZQDWdAVDfAPLNPo8zGbcy9Ji5GyTacicOSWvrtV9PrqsD0awPP+thi0S8zW995DSmamFRkRtMWLVW0ASuabQy4TUqfNPl2JL/Whwl4ajVfT6l/C3zmxvuEk3cJVLhn7vFOy1IBu5OrEVCjKvDq7rguxrYTbRKcJ2m818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DgFB30b1; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DgFB30b1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750747946; bh=xAP4VDtXDB8aJ4fy3jRl90NNCRDR6SwmqvbAMYEVAac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DgFB30b1tyg9i0e7RxDqOKyxYFi5bXCbr3hGnCBqO3HX+VWvkxaw4bsQyM9n9YK/r
	 2V0kLAJu+Mo4G6lpdm1D/x6upd3twnpdZL8k+9h1B8D5jqhubuG9o28gKT+7lAtpC+
	 IIVlm1Zxsj+CB2LLVXTXQ9dSs90Ajz59TXHXGcv4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 9AF8D82A; Tue, 24 Jun 2025 14:38:47 +0800
X-QQ-mid: xmsmtpt1750747127tdqm5337r
Message-ID: <tencent_4EF87A626D702F816CD0951CE956EC32CD0A@qq.com>
X-QQ-XMAILINFO: MvM61XSVXCtD9I5tNbXt4gI5iHx25tdK7d4vJW0dmMBXy9BBF8cQO/Ggt5F/aT
	 E2X3U9k1qBC31Oru55M61vLeKp35tvHGuCtMnTEAcjX+0HYADQuY2D11KpP6ER8eztrMHrDgf0ca
	 pMN8o7beJpRWMm7UJ5ZbUFW2IFRuKRueNd0GGILtNcpFoRnatUuBW6ophhzoD4b2Y4v5d6/v9oA2
	 YLx6YT7jaokCsA4q25XL+rnQXpf7eDkoAnhUMtzVv0r33kUmMcWGVtl+SQRLaeTRErCEA9IjUJT2
	 5dM8247QoXqzYN54UrdyGuzpc309K/luJuZFd0+Ku4VYfwKKwMJVVdlbMVBezeXHx+7M/SHiowVx
	 jFt9oluIEyQFL3R6xUsMg5OXmZrBOOOIVJw1BJfiOegudrAx6q0l/oan/o1dSh66ghD0VA6oPTEx
	 WDT7i9K0mpEDc+m2tuTAhP4CsRXSH5QlJ+3yPXbJhHgl1H8KaF8t3LsWRdf6itlNxRSxbT5SyCJZ
	 DQ8908/55fTeltqCJjmeRy8e/CwZlWpyRo81mbWOrEr83DhuxiQzmttl7UUzQ6SUcNPpUw/2XVVm
	 f5Vu3fm91O+kcJSHr3+E8fEZ4wijurccJ7QCKzs6iYLMsi1R8ShoUMV8ZDgF0BlfxyN2Qo6BKGAh
	 Jy3Zu+a8h5AKGrOBN+3f7Q3ulU9S46ocC4vvC0fv2IWV6bpZXZy72GrJXfNMUq+mqUqVVmPi4fAs
	 K6lSHLT/XJ892Ye28vxTSo+skVlLfSIuebULPsLXHNktX+FcU3jLBxdCUBfFr+0oSQzX7Fm1y8QU
	 jyzUTuJnKZKgC2lyJB9iThsX/qP+KwA2hg5qdlQ+iBciDzrNbTFKacnDxPy+Zm62iBUHjFXBf3n7
	 xJNm6K97vBpPSWoWEZ2nHiO+Et9SctZkDYa9C/Cfzfscx4LaF4DPzXJzkq0HEcCZ44Vcc75pERHt
	 jP7ur8AimqFzQo3ZZZHSZmSGH85ru6
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] tracing: Fix filter logic error
Date: Tue, 24 Jun 2025 14:38:46 +0800
X-OQ-MSGID: <20250624063845.4097939-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6859ea24.a00a0220.2e5631.0044.GAE@google.com>
References: <6859ea24.a00a0220.2e5631.0044.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the processing of the tr->events loop fails, the filter that has been
added to filter_head will be released twice in free_filter_list(&head->rcu)
and __free_filter(filter).

After adding the filter of tr->events, add the filter to the filter_head
process to avoid triggering uaf.

Fixes: a9d0aab5eb33 ("tracing: Fix regression of filter waiting a long time on RCU synchronization")
Reported-by: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=daba72c4af9915e9c894
Tested-by: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/trace/trace_events_filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 08141f105c95..3885aadc434d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1436,13 +1436,6 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 
 	INIT_LIST_HEAD(&head->list);
 
-	item = kmalloc(sizeof(*item), GFP_KERNEL);
-	if (!item)
-		goto free_now;
-
-	item->filter = filter;
-	list_add_tail(&item->list, &head->list);
-
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir)
 			continue;
@@ -1454,6 +1447,13 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 		event_clear_filter(file);
 	}
 
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		goto free_now;
+
+	item->filter = filter;
+	list_add_tail(&item->list, &head->list);
+
 	delay_free_filter(head);
 	return;
  free_now:
-- 
2.43.0

