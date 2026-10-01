Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB985275A5
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868103; cv=none; b=LsfNQIAEzGxZpZ1q5VsT981tQnwzdIGPEkh7FNVeAls/vLyOgMNsGtt30Fs4UehrsqEvdp4Xmbz2iqveLPUPZxQCb2mg1HJWT7YAkFvtWbbQirJCV8lxa9ebruvtCNHjNiZ/vgV4PeF0oieyilXMez6aOjmy2cmdUwna1DGatUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868103; c=relaxed/simple;
	bh=xN80Pfs67HCbw+oDmc7ZViSyGz9ljql1b1gK0ht12no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kNqtKM6Bu8pUpyN4Zg0751UmI38NcIlhqaFH3otUUzyaUAXgWISjWAITRaga/DfO98IzxOmtavvQnJwCZ2Imcb3lxtaYdi8CPx04EuoA4RPCrY4Vjd93hLapVVYaqQud9WZXpiPIftWA9EafNcAkIOga0oY6cAa3s+2D6Ql5aUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxxF9zoM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxxF9zoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9nODF3ao4BoTMuSTnZHD2rQJuc0s627BBlq9bQmlc8=;
	b=YxxF9zoMA2r6kMkBqC1yqBZeePUF1rW5itmERNOzylre9jYBc1RZUF+YV+CikSqukDuDH6
	t5oahRVsIOmNViZ37YfjTNyDvctjLBVeFGQScZB8l0MXWAAHBaPovlQcicn6yT1uruiiUj
	CIu3s0LBrAilLUJZFw3mwOYiQexPiWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-7ux3MJHrOTCF65APo_aAiA-1; Thu,
 01 Oct 2026 11:21:36 -0400
X-MC-Unique: 7ux3MJHrOTCF65APo_aAiA-1
X-Mimecast-MFC-AGG-ID: 7ux3MJHrOTCF65APo_aAiA_1790868095
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 556441954209;
	Thu,  1 Oct 2026 15:21:35 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C0261800352;
	Thu,  1 Oct 2026 15:21:32 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 03/15] rv: Refactor da_trace() functions to get strings internally
Date: Thu,  1 Oct 2026 17:20:30 +0200
Message-ID: <20261001152042.124445-4-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: zkfjz-OoSbdo8Zy2NDlAlnRRb53Dhgc-omW3B9eM7mQ_1790868095
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The da_trace_event() and da_trace_error() functions are currently called
with strings and the callers are converting the state/event enums to the
corresponding string representation.
This is unnecessary and is problematic if an alternative implementation
is needed (e.g. BPF without using strings).

Change the functions to accept enums and pass the string representations
to the tracepoints only internally.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 6fc5ef8142ac..7f0bdfd7cce3 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -633,19 +633,22 @@ static inline void da_monitor_destroy(void)
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
-				  char *next_state, bool is_final,
+				  enum states curr_state, enum events event,
+				  enum states next_state,
 				  da_id_type id)
 {
-	CONCATENATE(trace_event_, MONITOR_NAME)(curr_state, event, next_state,
-						is_final);
+	CONCATENATE(trace_event_, MONITOR_NAME)(model_get_state_name(curr_state),
+						model_get_event_name(event),
+						model_get_state_name(next_state),
+						model_is_final_state(next_state));
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
+				  enum states curr_state, enum events event,
 				  da_id_type id)
 {
-	CONCATENATE(trace_error_, MONITOR_NAME)(curr_state, event);
+	CONCATENATE(trace_error_, MONITOR_NAME)(model_get_state_name(curr_state),
+						model_get_event_name(event));
 }
 
 /*
@@ -662,19 +665,24 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
-				  char *next_state, bool is_final,
+				  enum states curr_state, enum events event,
+				  enum states next_state,
 				  da_id_type id)
 {
-	CONCATENATE(trace_event_, MONITOR_NAME)(id, curr_state, event,
-						next_state, is_final);
+	CONCATENATE(trace_event_, MONITOR_NAME)(id,
+						model_get_state_name(curr_state),
+						model_get_event_name(event),
+						model_get_state_name(next_state),
+						model_is_final_state(next_state));
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
+				  enum states curr_state, enum events event,
 				  da_id_type id)
 {
-	CONCATENATE(trace_error_, MONITOR_NAME)(id, curr_state, event);
+	CONCATENATE(trace_error_, MONITOR_NAME)(id,
+						model_get_state_name(curr_state),
+						model_get_event_name(event));
 }
 #endif /* RV_MON_TYPE */
 
@@ -695,17 +703,13 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 		next_state = model_get_next_state(curr_state, event);
 		if (next_state == INVALID_STATE) {
 			react(curr_state, event);
-			da_trace_error(da_mon, model_get_state_name(curr_state),
-				       model_get_event_name(event), id);
+			da_trace_error(da_mon, curr_state, event, id);
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
-			da_trace_event(da_mon, model_get_state_name(curr_state),
-				       model_get_event_name(event),
-				       model_get_state_name(next_state),
-				       model_is_final_state(next_state), id);
+			da_trace_event(da_mon, curr_state, event, next_state, id);
 			return true;
 		}
 	}
-- 
2.55.0

