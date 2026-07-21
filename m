Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895CB4CA298
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630193; cv=none; b=BLTlfJUX0cMO8OgY2gZA1R+2fytg/iH+Kjw5sqUGYmwratGSMxJjttC4Rh9HBazxTvxM8saBmao1eYTr8idPfpPI3sTgCTGJyaNjkEKa+IfnV7xdfufnfNtmFs1Znqh2YVoWFaa3Nf4YRFehausxg1wL8aKcJJ2NxNNpw8uVkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630193; c=relaxed/simple;
	bh=FLFkp+3eSZ4USJ46uyx4rPcoDCQj/DsPKiGCXffD21A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvdEVKpxh8ZI1edJlmjbpnbgdvz/ni2iFqgvgpCRMFU3vTU6VH7Iq5pS2ekwUYvKXDE5qJoiJjEmqVZBWDhF8k5k+ZkRKVF8FLofDJMu1qo7qElb4VTrcux1yo7pTf4H/9qei5A6YryYNnyS5GtOl65v8+5QGmGSFgWNWft3qXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1o3xXmH; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1o3xXmH"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69e929fdaaaso3798422a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630190; x=1785234990; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ifp3mulHnAB+oWPwBL/RLrRmg5oT5yreNnfi6xRvgLE=;
        b=t1o3xXmHdUK1hA+dbldpvu1SxvNal9+X47rKdHO92mOEguY/5+0AfTAcI+b45uQA6Y
         wnwy9Opnm/E5eOSC63vbQC+cHtQFsC22GQ6FscLIsjGHi4FX4SONPtsxkHm/9MYUwt2s
         kUlr1ldSvFSLKmk6xE6dhoew6IqX24nbQjfIP4UtTeegTo+BRL7tNriKI6m4GIWgqrOE
         MDuI7JpBWcSohD+zooHix9l7irvmWn43U0/aGGtne6oUvpfLpboMezs9vPQu9UK3ev2W
         dusTA5uHPFLVcwNyRMGS8Ymfyy1+kVU0mZQAGK4BV3og/AC3MoVaCZQvPQyWSbsMSRQ7
         VDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630190; x=1785234990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ifp3mulHnAB+oWPwBL/RLrRmg5oT5yreNnfi6xRvgLE=;
        b=KQD7/BIsfbvPae+tu2knmqCF2t6RMl/5ZqD5jTK6ttmrdu7zP7PXUbqRgPQ3I9jkyC
         5hhrL7DZ5wa13mAG/WpxiSKzxZJpjp/YdfulhtAMEj7+dkyta5JRAV8oHeK2ujSmsPOU
         lPEc8s8+yK+sEX4rAXV2ICyFgt4RBM6XOs6+7GDe45dqbXgFU8bMz6BD97pi6ndv+BUn
         ab1dH2wF2wERLjZlKL8CYDlhoo1Ie1f9jR6B/KC4xy7fs6TIKLStoJFRn9ZwwR1hffR0
         N6ElKnKRb/igHjxDGKqb7E1L3OTXc/Ukfo+yC8gcdOPWlDS6xfNCLBOTAmd4nORbtFdr
         roVg==
X-Forwarded-Encrypted: i=1; AHgh+RpPxL8qTt8TIR4pqPiYPTgDeoTKGgJ6IKFpZs3lMU1qVfdnRyFNOVqkvLKxVvwSeaIXfK4pfRkSn8G+T0kt2s/92Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFdIwFR919pfOE/ZrlLl6sutDnRhNT5E8+powc2PSAAL4j1yo
	7YRFrsMFrduG4bi2Em8pBTcVO1ujbaKLGegvZlG5cuZ5ZjZ2JYrilfkHvnAp7QdVsfmApJM9LFS
	6JYjQzDjow8JnhIA7AdFqpw==
X-Received: from ejbt25.prod.google.com ([2002:a17:906:659:b0:c15:c38b:8d37])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1b0d:b0:c08:22ae:6f46 with SMTP id a640c23a62f3a-c16b4795cc8mr827893966b.53.1784630189468;
 Tue, 21 Jul 2026 03:36:29 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:53 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-9-vdonnefort@google.com>
Subject: [PATCH v3 08/18] tracing/remotes: selftests: Prefix hypervisor folder
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid interleaving run tests by prefixing the hypervisor folder.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
-- 
2.55.0.229.g6434b31f56-goog

