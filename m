Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224896;
	b=Kv52sXOCsdWv/092V6CaNEkLn1CNBr+xhwGx8hNz1IpfpBkCPX3wteJVrwnyX7WOCRgT
	 f+L0Om4v+g+Olq9A1fHZ1SDpmzLRK0iYB+724D5+a0m1Yv9w/t4i6X5huHJSM1jNw2adp
	 sY6rlGTZyslZOkIcxSO3Vlvv5QOC16TkFFDbXOpLw3cvcjXCBgOipw0uL2ToJ4RWeKh64
	 TqOK3faUy97o5kGz9Mu/LWRmR+lOijbX0rgnThWhr03SPGPY7Y+NM8m7l2502MDZNwMZS
	 Woeu4HIOrx7EniIlG4ZgoVFkekIaQZn2z6h2MPof3hyUwqC+WWlA8gnllwwoKeIA8PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224896;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=g53dYdWmx0CWu8YLhtHzIegCu2ZJ1kKP94JjlNGZ7jk=;
	b=4daYKn6iFXXfrCCB6UJGv9ViRS9GZ19VXOYooLR49sAdgBdHSaINduZFVkmkMRMBGxMH
	 zN8UDSAX0nKsUNl9UQGjFX8euyxFSCdxnzgPH3nwunrOvGLRRfj9omYUUa8LLSus8GYAK
	 gS6NlboM1lX2EEWvZKIhC64EuqPp7olvYsiaqgZSwZkW2k2/N8KnM8KQKEW4frYwqmyCh
	 Udks0GLbiA6fdypGEsW5hTSQ1lnRsXGsKTw9FvOkFCZj6MSJJs60B/Ji0CNpWaTYiOe64
	 h1xozwk/JILQLFgKVfCPAnHKJYjGMHk24PPr7sHiCPMbySPVMYQt1Re1oVkjANsKbbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="YZOhcVU/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B2606A31F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79B2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YZOhcVU/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g53dYdWmx0CWu8YLhtHzIegCu2ZJ1kKP94JjlNGZ7jk=;
	b=YZOhcVU/k5SK3jmsI0x1LdA3dRGbocSRII95Mpp6xv9LdTfHNWwSL9WcHdm9656GiNAKS4
	KV0+U019WP3r3Pxf5dwWs2d/GnD3+YB4lwxmtQN67e6AhR/R7svZ/wwjTtTPyv8hTmjaMg
	5SMH5PsRd0AkFhhG672y2ECR9ABD+bE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-DnaPqjBuMzORXuVx__RuNQ-1; Wed, 28 Oct 2026 18:01:31 -0400
X-MC-Unique: DnaPqjBuMzORXuVx__RuNQ-1
X-Mimecast-MFC-AGG-ID: DnaPqjBuMzORXuVx__RuNQ_1793224891
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53661e036a2so31235281cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224891; x=1793829691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g53dYdWmx0CWu8YLhtHzIegCu2ZJ1kKP94JjlNGZ7jk=;
        b=adStgSjbta5e5aK3//zrSgSiMT5SFTpMrYuZ7r+cXomiUHUJ/dfbRlRN8FhrEsAK1F
         UFlWP+racOMtq+gAtb3vcdadPdi9OaO/Y9Fzo9faWodyzslo976iGs449c+X2vpKlSMS
         DZzpxgXfk81kEPZtfCdoODY3DgXaKNnwT4kb5ji5T7U7h18m5pojxUSvjHr9GV1Repsa
         mGYBvmHiYMU7BD3eurscIQKwXp6nS2igEVYcRKS02NgVd4jZ5jbrqg75MSuXQwXMf3lo
         UddNY0MsI7n8+F5WKfYsVoZF9m++tvHzI4EpYa7hxHXLYqPDlqEmIihl93nB2mQXmalx
         5gAg==
X-Forwarded-Encrypted: i=1; AKwUvBy2lc6tkODHuXLooCupWDWAJrGHoAZhamxF9O90ZWz2HjXgF9mhS87QAUiHD4VmkZA+Gm/FXiFyQO+jWixRiyq5+3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKy+CjB8vEzlIj/idRV2Yiuw6WdxdWqLe4PUC2WjbiGA6r2w+0q
	jEm8+mvqchLchdSTdfLwAdb9iFoSYiwennuQJ6krrZ7A5ScmdufK3cbsv89rP8YRpDIZ2QvQimc
	kg/J9OXcYHHaAQYjdK9L8i30EUbhwEchFYy8WPV69nCEeJaVTW9a3CV5hxFYK8x8D02/VkaLusm
	HYEW4hPQ==
X-Gm-Gg: AYBFou3IDhACNakR6cEI1vWWGgo0/7bNW8imrIgtCp6kb03MrWZ1NOXqqByIBmRsJgj
	JK7L3Djq4w85PEJ1Jb1iy1DXGOJCb3nS5gMZeukRWgxOkAcBiLcQxPVL95p6elK/sXXkJN3lcU/
	rStJfTk7d/ajWO1+Q4hwmTtURLGsRPXfywsNQl7UymFhkorAJVe1hGA/A20WatQthhwDv7hWF04
	nb0NKaJfmdl8MnyXHMSE4vp4BthZ1ut1Fg6bCESEOQKkricJhoJCOjPDoWFErFXwWpMiEfZUBHA
	uIYxQtaxvYGLSqmbac34fh6WZU3y3rDF2TjA3jQgRs7gR9A9KVVNWn1/XQKoL+yIg+vpfAK8LEe
	4e9ml/QgRzwTMTGT7sfAgRU2U1gIC74c7YzI4wtaRtB4Fg5LtB6KmZx02AF/PHL2zpmgqbdfsz8
	bALdUM0MlZPdd9eupjyhHBvq50t//B
X-Received: by 2002:a05:622a:489:b0:537:83e9:b0e6 with SMTP id d75a77b69052e-53fcb509fe2mr65056271cf.26.1793224891172;
        Wed, 28 Oct 2026 15:01:31 -0700 (PDT)
X-Received: by 2002:a05:622a:489:b0:537:83e9:b0e6 with SMTP id d75a77b69052e-53fcb509fe2mr65055491cf.26.1793224890462;
        Wed, 28 Oct 2026 15:01:30 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:30 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 04/10] tracing/osnoise: Hold a ref on osn->kthread
Date: Wed, 28 Oct 2026 17:01:14 -0500
Message-ID: <20261028220120.4005187-5-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028220120.4005187-1-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cLQMerrNELqzQNcgNx5cqX4HzhWx7o3OqYHmeLya5jI_1793224891
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Deal with early kthread termination by holding a reference to the
task_struct and always running the cleanup code in stop_kthread(), rather
than with hacks like osnoise_migration_pending().

This avoids a potential deadlock when a later patch switches from xchg
to using a lock to protect osn->kthread updates, and also deals with
any other situations where a kthread might exit early.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: New patch.  I did this in response to Sashiko pointing out a deadlock
in v1 with the use of osn->lock in osnoise_migration_pending.  That might
no longer be an issue now that detach_lock is split out, but this is still
the cleaner and more robust approach.
---
 kernel/trace/trace_osnoise.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index ff7277052af2..5a2294e9c70a 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1691,17 +1691,6 @@ static inline int osnoise_migration_pending(void)
 	 * thus: taint and leave to unblock the blocked thread.
 	 */
 	osnoise_taint("migration requested to osnoise threads, leaving.");
-
-	/*
-	 * Unset this thread from the threads managed by the interface.
-	 * The tracers are responsible for cleaning their env before
-	 * exiting.
-	 */
-	mutex_lock(&interface_lock);
-	this_cpu_osn_var()->kthread = NULL;
-	cpumask_clear_cpu(smp_processor_id(), &kthread_cpumask);
-	mutex_unlock(&interface_lock);
-
 	return 1;
 }
 
@@ -2001,8 +1990,8 @@ static void stop_kthread(unsigned int cpu)
 			 * by killing the thread. NOTE: this is a purpose specific file.
 			 */
 			kill_pid(kthread->thread_pid, SIGKILL, 1);
-			put_task_struct(kthread);
 		}
+		put_task_struct(kthread);
 	} else {
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
@@ -2060,15 +2049,17 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_run_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
 		return -ENOMEM;
 	}
 
+	get_task_struct(kthread);
 	cpu_osn_var(cpu)->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
+	wake_up_process(kthread);
 
 	return 0;
 }
-- 
2.54.0

