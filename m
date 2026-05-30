Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319403C1406
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150662; cv=none; b=l7aZ+diAqi6erynxJ0WmDM34TAmtGwChSv2k8aYKkkxbb+ul+0Gq0CJXY5tpRlNRxJG+zN6loymf85JZijoDKlORh85BFCgZX7GD9mjCaIbcJ8H2paDKGxsJI1DiyxLdYL/vniw/hbqCQfjq/ZKB+FzFnPFt56ypxEZQggJXCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150662; c=relaxed/simple;
	bh=VUpfsFc62bFNBVbMzaTza0SKHhnDqyPiMbii4gCBqEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Xfjuzp6dXH5hrjUGnM7kZJppPdW2nTpeNjHIgairmbItPk6xatiSGy2iwXWt6jQ56lS/RUyy2loKCgd+3drMbt7lm4kxhJA/zW/phNUFB4qhEjLScRkoCi0YrhLgecaSHrYqFSnpwVjiM6/BTfC1u09FV4dD+Apg4AZRThINi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlEM2/Xo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlEM2/Xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNimF1QAk1+ATYYd1bb8YN+Y+pOQsQfgOs4cRpBAAPE=;
	b=FlEM2/Xogx9ma3isjnHpJoI9X0cHWaup0Xo32wqp25GzZ84/fBFhal0I4PjP/AGECOZ7hN
	kA8XFBuMedba0NX9FXT/fg/ptO1Y72koNU1RUG/SZ2wG/3d6x6gO84g5qyZaVUGaS1NiCM
	kkJ5obUNbGFls2eujQ9Efx3Q+LTdO0k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-KZjYUwxRPcSiLEqG-k0dmg-1; Sat,
 30 May 2026 10:17:36 -0400
X-MC-Unique: KZjYUwxRPcSiLEqG-k0dmg-1
X-Mimecast-MFC-AGG-ID: KZjYUwxRPcSiLEqG-k0dmg_1780150655
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BA29180044D;
	Sat, 30 May 2026 14:17:35 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9335D30001BB;
	Sat, 30 May 2026 14:17:33 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 12/13] rv: Fix read_lock scope in per-task DA cleanup
Date: Sat, 30 May 2026 16:16:51 +0200
Message-ID: <20260530141652.58084-13-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: FXuQpv4UclJZu5ccWNbLuNIVoRT3sG-bMMsAtOb6ixc_1780150655
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The da_monitor_reset_all() function for per-task monitors takes
tasklist_lock while iterating over tasks, then keeps it also while
iterating over idle tasks (one per CPU). The latter is not necessary
since the lock needs to guard only for_each_process_thread().

Use a scoped_guard for more compact syntax and adjust the scope only
where the lock is necessary.

Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ae8c35fcb..f4fc22cac 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -294,12 +294,12 @@ static void da_monitor_reset_all(void)
 	struct task_struct *g, *p;
 	int cpu;
 
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, p)
-		da_monitor_reset(da_get_monitor(p));
+	scoped_guard(read_lock, &tasklist_lock) {
+		for_each_process_thread(g, p)
+			da_monitor_reset(da_get_monitor(p));
+	}
 	for_each_present_cpu(cpu)
 		da_monitor_reset(da_get_monitor(idle_task(cpu)));
-	read_unlock(&tasklist_lock);
 }
 
 /*
-- 
2.54.0

