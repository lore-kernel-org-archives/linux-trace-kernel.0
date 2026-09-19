Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74653054C7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799308; cv=none; b=gIIoky2EMZeYnCbItuhCYaJXi3TWQdx3jzAueqWjikwDBVDzNkgsZEoUMBOMYPvEIOLZS+9DOOxx6GWcMWuwkf34sAiysj17rV/IQx5li+r0Xo2P+i6LWZReQyHqlfTD8Mb/T2YX38fCJQZmYfyMEu0zLpQxmns1ACC7rIRr6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799308; c=relaxed/simple;
	bh=a6Xngaoz5LuCniBXjc92yGptZdQePPtIJ8MFTh1gGLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n4fBj1QTrw5SLJHE776yoMrvcfLtPA3wlX9QIURGkTioS+J159+lFEhqZGXFx0hNKzhMipO2v4iJzFUCOD0LhjG5xfXnEI6VCFCqp53IS+fBbeN7K0zMkD9FyvMQ4AWPB4lD1hdYcBJWJtAJs8CWXvdgf9EOEWBReaWOjAnwUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bD4BzPi0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD4BzPi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789799305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bq1yfoRPtoq1pUpAwOJciQMjZs09yVPawN3Kdve9ifs=;
	b=bD4BzPi0W1+2WsGOlVN6YC5sXgVfVoNTr740xAcXEt5HVhpTTz/nxfZakz9GTLgoI2Yz7Y
	XyYpDbQcQPiIc+D4liWVSr6sTUA0RCeyetkIR59pihjpoNSkrYLFLNtB06w5Wv3SJh9jAt
	yl6WJAOdqQEI6NKUjmwv7Km3wDko26c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-6_ceKnt8MSml7apoKG2-mQ-1; Sat, 19 Sep 2026 02:28:24 -0400
X-MC-Unique: 6_ceKnt8MSml7apoKG2-mQ-1
X-Mimecast-MFC-AGG-ID: 6_ceKnt8MSml7apoKG2-mQ_1789799304
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a3f673221so49384285a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 23:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789799304; x=1790404104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bq1yfoRPtoq1pUpAwOJciQMjZs09yVPawN3Kdve9ifs=;
        b=nqjARJr5qbxC5Ju69FAUGL+1ASyIabPvwH9xv4g4ZphTZcknnvdu9KX8nkp/5qhiux
         tc8WcT+dHGJYODgUw9vveBpio7b12DZ4xn7WlDCSxLsPDbYRpLLW34tHJySxyUjytfDr
         hMpMf/sAmmur7RZzXtb7Bz3mS0aSSBakw/Dcqx7xMrYuh/L282SeHDY0Jsh7P0ikIZqV
         gcLdDl99OOY6DOZ1yNqthNEcJPKfwX/dYa2ROyK/99bZtV+0ZqyiMffQpRc7P63Y6kX5
         lI7sb3MJzg7lGXikSKKC9JpPQQ6bm+lNnCjI5MnMB2JbXkoEKqNOx4B+Ji/5hrrl7Sdl
         i5VA==
X-Forwarded-Encrypted: i=1; AKwUvBw6kr9CIVzdwx3tdcFenp70SKwjC6S03GIkXdeat/rB4JGJY4mvEvelVoRNJSKEKnCLAtd9TSi+qjOMfkYeZ+WDfS0=@vger.kernel.org
X-Gm-Message-State: AFuF++l628LzMD303zmXG6TOhJ+KTejCcXZ1s6+BIYkZuV7EO8wXbF2s
	vMSzxXlEi0oYbk4gP4dPb6gcoN+41ZfhSzhlfIkwRVRy9Ue4YK5Kruyk9dF1qz4o3T/+5iTNejT
	MyZ3qp5Rz3zcNRF0uFd6AjYq2y1+oplCPMK+1msZO2Tb8vBXJ2ACfHthnq/AW9lvqJYW7PuwXIw
	==
X-Gm-Gg: AYBFou2ptSTtKUerANAWAK/yqqYabTpPjXVD6LGOgnHk/Gg8biFbbv/h0rgueQM7Rgc
	UGrQzk19GAPbPQ6ih3wYaxCwhcCvnXIaJlkftc7VnMFYewxyq9rW7Nmr3TYRRZuFyPpaec4buiN
	r38rDtGMJifN2NwfieMUYzT4/95fW2BaoVMjWA1Aa2FIGp1BJX4xMmmBRHRN8PPLxCY1Djdj+Tq
	VdPOpkgDGlotm5AHSvspFhXj/U2SoZ+5bgUmeNMhW13DpVJdkr//baW6oAuVGVYea90/e+2c5CI
	EF2Mp+gsf+08fmIh/iUyFphEhjRmZZ+YTwCe9QBUObAOTJq6KHmfScqfZrj/39m0SNvjcj5EnP3
	x8rz7hrblvlTPrDauqzVrU3ULglu+WgUS
X-Received: by 2002:a05:620a:838f:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93bf576a7bamr28600585a.61.1789799303811;
        Fri, 18 Sep 2026 23:28:23 -0700 (PDT)
X-Received: by 2002:a05:620a:838f:b0:93b:d7a1:ba12 with SMTP id af79cd13be357-93bf576a7bamr28598085a.61.1789799303083;
        Fri, 18 Sep 2026 23:28:23 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedc103e7sm120834685a.18.2026.09.18.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:28:22 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/3] rtla/tests: Use absolute path for $RTLA
Date: Sat, 19 Sep 2026 01:27:54 -0500
Message-ID: <20260919062756.819701-2-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919062756.819701-1-crwood@redhat.com>
References: <20260919062756.819701-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VM4WGh8SOoc31dPLNKlE7u1tgEkovTWxRnZjfDJnEgY_1789799304
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When running the tests directly instead of from the makefile, RTLA
is likely to be unset.  The default "./rtla" no longer works, due to
having changed the current diretory.

Fixes: ad5b50a0959fb ("rtla/tests: Run runtime tests in temporary directory")
Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 4287cd64ac31..4fe7bcbab8b7 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -7,7 +7,7 @@ test_begin() {
 	# Set test directory to the directory of the script
 	scriptfile=$(realpath "$0")
 	testdir=$(dirname "$scriptfile")
-	[ -z "$RTLA" ] && RTLA="./rtla"
+	[ -z "$RTLA" ] && RTLA="$(pwd)/rtla"
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
 }
 
-- 
2.54.0

