Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A493BED42
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281698; cv=none; b=Z+107j79alByDUTM15r82GXl2xV374BO4mfBopRvZ51aPnpKKTxy17njhrqLlGxagPKdfOaeYewYL9YZgNyKBhnasjvxyucnMKiJE7i4DFp96hgn/dJP+UIENiG6UFM7QVUW8+XGCsBZaMhZ+1+ZkWwCz+1kgn72Ycp5swhhGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281698; c=relaxed/simple;
	bh=nRir5v+6LbzdGv9qh2mWXxT+gSGB0K8Hs1BfKYmoCMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+Pd2MG6nSveJ1ZD9scqpdgte/B8vOEK4mXkd8K8Lv8WhQEhKsvdiFDma9l6lR1cC9gzrzGEEUgVJtTgr7UlR81TT8PJ68HUpr/C3vzCkUZh3kJ+jTACylwbpi8AvcdDomHRDj0dNzlrfpaZGFN4i1XP3oWWpi5ouoYBWO1eLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=eL72NYEl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="eL72NYEl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc137464dso456556685a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281696; x=1774886496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV4QS+yC5xdWAGmIg+LeuXzS9pCzT00lLs26Yre9ABc=;
        b=eL72NYElWH2iC+/O1dmlJJitOP/i4JgbyCbHwvkJIV9nicRPRbCmh3INfW9Cvc+Fss
         ScNnJgOAjYoj6017h7+Eex+P7DBptEMHyjD3rV0T82bNfAG4FaVJ8M6egqeam5iISaoY
         yx8Vz3luFBC8AfR4Hc/dG6xaMjTS/TFRgAkORnyNadABV2LxcKQgfM8C6AfwXl4e8Mqc
         cZue/EyTQ2fFKC7cHvMrSKnuvY82Jk669RhdPK6yEY7yOBAPDjWXmrjigU7Ng36OYif1
         fBSQwQ0MmidefDnfw1cxSfZ7VGJQ4bp9ok3JQPIqhkjllGoxILlhJ4Y69gEKU+2zAeaB
         Jf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281696; x=1774886496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BV4QS+yC5xdWAGmIg+LeuXzS9pCzT00lLs26Yre9ABc=;
        b=Ql2hqeMnzCW5kxvQi70w8jDWxVfGkT7AygHJyjiT+mXwP+ed3JVt5iZF/duOvx2yL5
         DHrjcCgBn3b1ZI05/MXtba0RMvRtHO1QF5IdEoE85+qwR4QpR+L1letyo8mZ/Oj5n7D8
         mpui2t/5m7lg4Rg9H+mCD1u7n+uuk1b6EbdpSRJ4EocS00Tg368d41FVazxmGuAXX9OC
         NrpWlFc74mHpMi6WlJAvhn+zZiXYWUw1Qg08kFpKzpbEUxSZM63sVvfl5FpmpJxgaJSR
         e2IxKuCSwIxTGvm1gHelvkwjZOhkbL6x0x+WWJ2zUsJniOFZEmofHkeb5HHzooXq80rs
         16zA==
X-Forwarded-Encrypted: i=1; AJvYcCVQjKIYrLs+tJ5FIPA2uA1ArtSNyHtdW92AnRc7qjLUy54p7ib+E3xn0XR16LxKvutDWFU64+m8sI+h7R+zUccW5jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0A89cP/sYWBugtZf3zzU5RDL4ppxDCQsN4br53QUK3xfm0Lwg
	JOK7SHICSqXbJ6lqoJ+y5OSH990E9LvOFEuVqtp2uK2vWTC24CO/AgKOJisHhCKhvgU=
X-Gm-Gg: ATEYQzz0iayr0oE08cz1b37BFozs9mlOLadDgC6YNgsPbwKHxBTaGOgcK/sEdCwu0wn
	sPWlUeHbjGYy+PMQIW3a2EA57bDupZJq1FsBDDW3lULAe95ouF+Bj1HIoKngb1L12ZSi8QnMxah
	HXm9eC1hYQ9RjogeVnEP966If0mJLWSokyrQ3oLjwlmlns/EEkBeas9rBML2Yz1+eGXwYgNKcLj
	xV2quto8XvFUqgNN0LSxZy7SUbpERtbFq9ddkyhIx4pnmQTdpbWhd6xEHPzAXNy8VDKwld92XmX
	5BsrNo6ttYIH2CMpBWcRK6vXMD3ZXOsa20dofvs9hyoJiii9qhFiSukgBJluO8cxP+sqpwPbRbD
	Fn9NYbHjWGdD9b9RTQOuYhBIKEVmhxlisZLTis1lh5o5gOQPuEZUyALt1sonRFuNZq55mXLZsKI
	Wej5/LMOB6cIo+pBfdVLo2YJ/XRT0TRAKVF7xab+CnaY8/GCDh970K/vs97erbl7qbfQ==
X-Received: by 2002:a05:620a:4707:b0:8cf:e933:d5e8 with SMTP id af79cd13be357-8cfe933ee7dmr479191185a.44.1774281696047;
        Mon, 23 Mar 2026 09:01:36 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:35 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 16/19] net: devlink: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:35 -0400
Message-ID: <20260323160052.17528-17-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_devlink_trap_report() with trace_call__devlink_trap_report()
at a site already guarded by tracepoint_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__devlink_trap_report() calls the tracepoint callbacks directly
without utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 net/devlink/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 8edb31654a68a..d54276dcd62fb 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1497,7 +1497,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
 						 in_devlink_port, fa_cookie);
-		trace_devlink_trap_report(devlink, skb, &metadata);
+		trace_call__devlink_trap_report(devlink, skb, &metadata);
 	}
 }
 EXPORT_SYMBOL_GPL(devlink_trap_report);
-- 
2.53.0

