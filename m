Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442356;
	b=xeuAonY8MxApx3ZGE2nZlheMyItaTNN14XqtByCm01vESDZynQEr2tFIlgX9DuuJTVFG
	 6ZTdsJnHXEYLex3DchGYlJHwItn39LyafKZU0JMsXP0oVCucjpyOiGfjRGvyoCeelFndA
	 aAk1WEyIpBVqmhbPo9X8crAVqGqgzEWFK/b1yImrVkG49foHjzjb8TEPq5cu2vaDg8tce
	 EWEsiFzV+rFXgGy16bpS2uNhMAyGnxs7SZXNVXlRw2P3aBb5ie+05QJfVGowCQSM++6kS
	 s6m++Oswwdj8MjMj7RfWUqJdfREk+zPsOow89dvZrk8LRUhVPJ1cydQPof+vlaVLbgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vtSAjOIAbDssVymEX9DGLCScFHFuvzma6NQTXOmdCRg=;
	b=t5D5be6imGWk2fGGsy4JhIVljgzi5n2O8cbFG2ZXc+1AEhJTVQadp8w7mjZUPiCvvs47
	 KWNLA7Iz7XMuF4R0c3Cnvr6yyCL2VKjdzpFlNwJdK9/mZXIQnDG9qeA/G+1wpjIvGzXyC
	 C16sdXFGbBJqZ4ohhZA3khpLWk4kxMum6+a/1ElcRXgX21xsXJ6k3YLnY4DyFrhUJ7lNu
	 Ym1tPoBVa1OtjOqRAkkDwyfXNC8ipcoGQlq/xcyfrwAH9kRMSIhHRHh4Pg97a1iHYGfgL
	 lk/Ybuzlx37flYwwFlHKff+MIWCFUMZaLVBTsy3cTpSnqD2rf6xzg99duIf7bV7LQrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUqRNiVy;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7A606A327
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB7A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUqRNiVy
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so11775415e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442355; x=1794047155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtSAjOIAbDssVymEX9DGLCScFHFuvzma6NQTXOmdCRg=;
        b=UUqRNiVyTsYQypnn8L5NEyHxGAyUxeM+mTTzxSi435mapi8rPNsE4dNsA3yr2ad8gq
         g1ptiL8jczjPMT+7y3mt8ZuTP+YshLzUVbDjF+GjELDuNU0Sp3QdJjmQha1AginSYVt8
         Gx7McEAiXN2IbcC8viM4yJPj42tsRSSZuiWP3Lm4+p8jptajx6gWAvk4OEtcp/n8Ss52
         TNg32G2QZJEO3Vlm/YegK8wrQ2wjAUeeisCww/6N4v9dQ4AbvCn5CGTM6VoJuuTeBX1X
         ercOsg82CGI5Pu3x12W7m/CsFrksqmgzY4z5NTuyqWEpWd9fccehIMDIn55AEb4D+Nfe
         eQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442355; x=1794047155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtSAjOIAbDssVymEX9DGLCScFHFuvzma6NQTXOmdCRg=;
        b=20DMZRJu8Hca3GRevt594bSmVGpQySK3cfXIU97LeoqjgIJho6BmJQE6xaxrDz2Hdg
         UqMaPQnKPV23vSwLkEVirVuMUf8CbkFMG2K8JOqCaBDjjZRnanWNnPGbockW41rtBP/V
         UxKTvTL6Bl3EtWvQZN+YwiIdWLKbAs8qwA7p1O6tYWJyndRe6dS0IDOQVaZkuQN8xyb2
         6jlqjrfVVz0wC+U02uS2nA6Qb22sec5dnoE/jG+WhHmybLBhDCYYVh61f3N8bWvr8pwV
         CMa5w+ZXw79ScqjFw4PkXVpXRkvrPZXQ+WLIrszIWit9XGrF+6whB0RybTXfc8j2vv/V
         2tHA==
X-Forwarded-Encrypted: i=1; AKwUvBzKamirA6rpX7udxiBRAevqr+LrhzZ222KE8QbRmSl+8IPRWmM87I6xncVVsrRnvwLnU3Ihs69P0jPpfe851CZ5NLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+YDtnazagMjfeSrU4zhQP8UdGQ51CIoshCbCOED0E8GbbdF9/
	B/WigWAsXCloxhN+UCu9OKbFpE9hSsQldH3kFjyweGGSIE5Q3sbJ8e8e
X-Gm-Gg: AYBFou0mOP31GKLQX8cLFpq336QftDcmR/ip86DA3XNrgy3jjKGVB3EycWQ7RkMad5+
	CbFkjbsS8mr8gz/P6jpDK5jTMPWT3LDZ1msuvegZv0kszXpASfHpXQoRCrU5DvRESt8RLgcbC5U
	VlzNsVMwg6Lxa8lI/UE+qT4DQNogb7QUFqxpajoZKA+iVI0qpe5mzumkOWPC2dE9MaoV1N28M9a
	GBxhefmXjtxCQeR1BwI9X362ldxLOiVuZwoI1LVzx+lwPvYaz1MfCa//sHLRHLhDS2TW8v7u7aR
	qlhrmNKimuAPAHNVir+7NuUyYEt8DDZel4BO7d2UGFZIUjCTgYYQGwjfHVwAl7WfyQKgIi1Yptt
	3amGBniu9AWLcARiCJyJPobSIU5Egbmv78NhN82+X6AuFm0EOOBoht7u4vbhtDCVjV7K3bGUyIq
	0s4C/5FFgUkMAIFS7PBA/2VFhZq2F7xZLlJsMW3XEU5Pqtuj+GOrRtAWjb/JTRi8/TqUiQONc4f
	drGUcL8CSIYtVq1M2uEyrdcgvClN/JQCIDStPZEMjoo/6ovvfaIaAC1EsSSlkiqlQ6VBdrT/iIp
	c3oxMnh6RXtOkKlTuqocUlqwFXMeMG0BFVDGPZfVIAbL4+aOcSiKjqAhkTAsVBEV/vRMzkEpl5f
	KFy6tqodH/WQtJlgH1iKfBjA6tjpB6+EHVw9lDujz9bYdUkZj7PPshSt4vOGdtX3a7QwFxkOL0U
	9aj5sJaE9NsFl8NfhowPgcMvAEzEEQQf1/EAc9Ze+csjGIEhgTdGM0TDtEIA==
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4ac1793fb5emr109362265e9.15.1793442355021;
        Sat, 31 Oct 2026 03:25:55 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-994c-f615-42f0-2afb.rev.sfr.net. [2a02:8434:fda5:4201:994c:f615:42f0:2afb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm195363135e9.1.2026.10.31.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:25:54 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] tools/bootconfig: Preserve paused histograms in ftrace2bconf.sh
Date: Sat, 31 Oct 2026 11:25:34 +0100
Message-ID: <25caf3642950b6c4d32cae945d034294bfbcf609.1793442331.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793442331.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trigger file reports a paused histogram with a trailing [paused]
annotation. Removing that annotation without adding a pause parameter
exports the histogram as an active trigger. Replaying the exported
configuration therefore enables aggregation that was previously paused.

Add the pause parameter after the hist prefix before removing the display
annotation. This keeps the parameter before any filter expression and
preserves both the paused state and the filter.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested paused histograms with and without a filter, plus an active
histogram, in a temporary tracefs instance on my Ubuntu machine, running
kernel 7.0.0-38-generic, with recording disabled.

The original exporter restored the paused histograms as active. With
the fix, both paused histograms kept their state and filters, and the
active histogram still restored as active. One filter contained the
literal string [paused], which was preserved as well.

 tools/bootconfig/scripts/ftrace2bconf.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index b63e04bf9400..31702be0c68d 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -114,7 +114,8 @@ per_event_options() { # event-dir
 		DEFINED_VARS="$DEFINED_VARS "`defined_vars $evdir`
 	fi
 	grep -v "^#" $evdir/trigger |
-		sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
+		sed -e '/^hist:.* \[paused\]$/s/^hist:/hist:pause:/' \
+			-e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
 		while IFS= read -r action; do
 		action_cmd=${action%% *}
 		action_rest=${action#"$action_cmd"}
-- 
2.53.0

