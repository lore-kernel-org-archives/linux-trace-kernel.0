Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B53A7F6B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015705; cv=none; b=mHNPNDAioP4Mj4GLyKWEG/tWH06Smx1x66HuacThOKcUSHhT8/M9cB28q1VaLdQuIG0TaJuSk120jp8VHasvSWyiWWqxWXK+J/9HpmwDKzz1lZj3uHlBPMGNzELxeWv3IjfhK7Ts4/T5GKo1fsNqSaog+dncozGB3df9ceFcsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015705; c=relaxed/simple;
	bh=YWhUpRjQqYozT3ad5UwGXtD/jYUTwOtwxXZYs9s1XmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Y0tAt/nq9a/IWemIQa0Ul7oqEka4W6cPGSxOfFNu6i/Rw49kxpSP0xN/DX4IatSIT50BAo1sVDu2leAqMCqgvsTGKdV6B+5zPuZGXIBjP24EHosTzxEiwe7pcifjVdWfbIHWHyXc5mtjEoFa8o89vhXkPqRrrBaWlRIOUlMN0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGosnOAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGosnOAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WmV0mbtNvqqbMh54hz6E3dz7S5bF7YT3jtJdJJsbWk=;
	b=PGosnOAaOWd7GY60A4yP07aeqsw1JxYtUxINt3lMfQHZckcyqKf52E3K5USpEAu4366WdF
	Sfrz1lUU9YZG4k6jhXasrzKwEn916G5cD4CitpIGo7Sn/KVr69XOeFrS+Adx3SNeI/0KjA
	kTKnTMroCTwxOjnojyveosldkZ7Q5uY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-SSM7elInMXKe7gUSOzw-Wg-1; Wed, 14 Oct 2026 22:08:21 +0000
X-MC-Unique: SSM7elInMXKe7gUSOzw-Wg-1
X-Mimecast-MFC-AGG-ID: SSM7elInMXKe7gUSOzw-Wg_1792015701
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53397b6e05aso99503961cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015701; x=1792620501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WmV0mbtNvqqbMh54hz6E3dz7S5bF7YT3jtJdJJsbWk=;
        b=n7R3NMTpVuTD7MHxxP/BxlW2xgPSlANXRQu9ftXq7kb9XOjivlDxEzB7pFKI31rlqk
         +6cM0o8b3CTa8WLSEHVARmTBcxwzeidvl1aU9hPSCpV3N6rwki6rMlBiWGiuBdE1f2yl
         waByLQt74hJ6WxS+kI1DUeDOyhl5QXOwTazvMqIeLmuryC9zsQrgKXTYoGje638+MtHx
         5nL6Gl7mo5YTxJD4v6YSiWg9zC9IPUCx3XpQXJoPmRlnbozBJyMNaKr/YqlnNXFXl2W+
         vjVw0mFfM1FnqaQpEny4ljHNOYwV4oRgAFsSohF6CvdU6rOA5V/GNdXf0l5WCwqyZFwM
         854w==
X-Forwarded-Encrypted: i=1; AKwUvBxZG2ZW1Ggu2mUFp9XwarP/+vyKcoRbtb/ESgc8OEEEqFNnonEAr7XgMA+2mUJ1IoV1rxB1hbxNDW2UFe0U8nHGKgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiWt+GVKdWb/IQt6moi55TmwIhP5HdmfoR1CnXhteUNhRPZTqM
	V+gOCG5L624xARvMRp/OpA/edui7HTK+URiYUkLpMKfnhYxdLykL5INi/SOz2RSEGNfNaOBPLlt
	m8sd3zzZ53sxJXQOKWj/VkhvH9vHGBqEQGdHip293FSPu+Of72+ip/FwGAISZFyWGzlnPOY84bg
	==
X-Gm-Gg: AYBFou3McpX6lhIYjRvf1KvvcilJrFcowKWt68FZfzIzVvIFVM8Ibrdr4shUIdxj5Vi
	oV0OPeGuRwWOVTi4CDsaiwusgoiNT3IqpJbxe/yoh44IlEeQf4R0R9/NwQ6laYSAdjStZ1Nmyth
	1agJU7Ih9Ciwu/aLlwu5buq49IkaPMeKghwAvH9yuubc+mlKR9FeIsqaEfVWz6Oj4nvcfrFUqfG
	mTmaueVj0kGzh3DEKRFRabXIX09cO5PbG3Ra6XarbHlSJYr/HafNkEG3xmJG7NpNcY/PPWI9DK7
	Lf7HkvkikkmzBVa/2xSqGDufVMeRJ+n56duWnkfMxS6stNLEvV0yDZwIJxZsNE4Aq+Nizt+B+SA
	9j4qjAjsA3rarE7IbH5aWEWXhrSEIywbmlP7ejK7JwSDokmicxYvK7H8=
X-Received: by 2002:a05:622a:130d:b0:535:1241:965f with SMTP id d75a77b69052e-5359fb9bd48mr260246061cf.40.1792015700679;
        Wed, 14 Oct 2026 15:08:20 -0700 (PDT)
X-Received: by 2002:a05:622a:130d:b0:535:1241:965f with SMTP id d75a77b69052e-5359fb9bd48mr260245741cf.40.1792015700290;
        Wed, 14 Oct 2026 15:08:20 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:19 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 5/9] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Wed, 14 Oct 2026 17:07:55 -0500
Message-ID: <20261014220759.908839-6-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220759.908839-1-crwood@redhat.com>
References: <20261014220759.908839-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O458Ia27uMs9Q2R-tohGLYyJrlU31-VYfRxAiDU0Ek0_1792015701
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can get here on timerlat with OSN_WORKLOAD cleared via
osnoise_hotplug_workfn().

While we're moving this code, remove the pointless compiler barrier
immediately before returning from a function.  Even if it's inlined,
it's not doing anything useful.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: no change
---
 kernel/trace/trace_osnoise.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 202d7b4254bd..3da4f1f095df 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2078,16 +2078,17 @@ static int start_kthread(unsigned int cpu)
 	if (osn->kthread)
 		goto out;
 
+	/* Can still happen with timerlat via cpu hotplug */
+	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (!timerlat_enabled())
+			osn->sampling = true;
+		goto out;
+	}
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
-		/* if no workload, just return */
-		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			cpu_osn_var(cpu)->sampling = true;
-			barrier();
-			goto out;
-		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-- 
2.54.0

