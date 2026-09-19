Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC92DF142
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799309; cv=none; b=j1V2Jc0Kde9lixpPI38lvz8DcdpK3KV3w7Vq2GDAsS6tGIphkul0XSEXTeQG1vnNCc5pDunJGSzcvA/xAuej0BYj1K0Fb00NwzlM7ePDDkGRZkCPcnLu70jDYLguasndpVGNSc0eN7qUDI2fTDBkvv8IhbYPGpnQXlvE2+r479U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799309; c=relaxed/simple;
	bh=w5x3QUm+n+5d/I9WgEUu9+IP3hq1WT4jqVwwjn+Makc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Fj1TJTNHzShwmXCueB922+E+ccwgBgAdAl83QMoxXGsh78ux9yvvqFwfVX6JxvLALO1y6Dy320Hia+nQt5z/BWL6LBXB8GGjJ5oGTniERvfLHsU7pMY+rtmarZJcqbxSWsmLpzG475ndeICujxh/Le6Zk44ej1GwCO/vrYx0ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsnbVHhc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsnbVHhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789799307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeRTuqfBLcdA3zp9PvXZEjBOWEA4N3dyZkXFuiApx4c=;
	b=OsnbVHhcpE0eVMiIC/18vtomqWzWyOJqiWpswjWfkisMlpztB608RuM87VcOJI8ZKw57Ms
	koqiBXLEIL4P8nB0aWTeo/JmUvyQ1W/6xcWuahR/oftx1SKjH5ZumGWxXxO7aHAqZUKgPz
	ReI1FjwkUvpvM9h7vlI3g5REc4bwHHA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-2b5lMcy2N5m7NS1_RS5rig-1; Sat, 19 Sep 2026 02:28:25 -0400
X-MC-Unique: 2b5lMcy2N5m7NS1_RS5rig-1
X-Mimecast-MFC-AGG-ID: 2b5lMcy2N5m7NS1_RS5rig_1789799305
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a08ff8451so244221485a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 23:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789799305; x=1790404105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DeRTuqfBLcdA3zp9PvXZEjBOWEA4N3dyZkXFuiApx4c=;
        b=C+R3KWeCn0pR12/Ylqg67a7s4J42P4lEG8m1wVlqe+4F0dIWS89oyQMh/I1n87LSO6
         Y+gPNrHKB/4lLJNmradsTMHwRMQwbwPh92Wht+o13vvdTK7D+08VnQBZQJJl+vER+QKH
         6BqfMSn7k3ScBJ1DlHcnCruNLzQvJR6WcfdQX6UEKt7z86fGqzPUa3o0u382Pu8zX0QP
         EBsOCko8y9xnvmdd6mxerd7g/tHYolov9Uxiiun1xt5VGIUqRashHlpLA8+5n+pu3Iwi
         vJ3JH5elwPN4zcl9pS8sx9YOV0GZ+gy8KAhU2dI50o2J9jxT8TYKyVqCxmEp/Q/1EE8H
         sKrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzf5L94xGguGdJ8c8q28yAIH74geEv6q4zH1i4ziD494+lCTDMI5Ip3t0SrjFRfL3AnmLA5Q7emD3V/ESWMv/oZ3tE=@vger.kernel.org
X-Gm-Message-State: AFuF++mKuQkB+YKtbNb7is4nn3FiABmdSjraxJ1GAQikbtCnk0VUn9Ut
	BshKGLidzaWB8TFwgrGmXc0d8jp7XZQkvqfBWvK5b1114N/TIo36TVcyfzRU/K59jhT24Xk25lw
	rwtz70QBpkoDkcHyHn29uZ/2OI1qXlKNnZHynNkX2UVW4olxfDf89CIwn79/wAKPDeNKX1eLS7A
	==
X-Gm-Gg: AYBFou1F3ICRYIDseJH5lXIRFe26zm3dhPBUd0faiaxON/hqkbPIp3W8DjdfgoK4cfO
	nCsnIe2yI0wUACu53tx6d+lfR9HCYH8DlzxhqzFZVg/1M3W5oDmILAQ7GmQivC5fHYPSWF5jVy6
	qSxAojPXbxC80mFGvDOlhjDuuJyU8v8dHq5N8Qau+fG6KfUjnSr/uP6n7sPiWo96h3Cey1QFT4B
	MXTEEypc2yJNdkPFxep/p7MSz0Et69Q+1dfLKC5hHyEOOusAUYEGSQaWoQvZb+nizpUtMDckTe6
	pIvBGaGZNTVSwQranLDctVDJkdnbDdN7Vrnu25MuuTQNpC4yqTsJ5cybGLAHEe87SDFcTi7XfQq
	FQamuJJK521vVPZYp3HyF2WLFzoFnZ4nk
X-Received: by 2002:a05:620a:7013:b0:939:fe9a:6437 with SMTP id af79cd13be357-93bf551bb21mr31976485a.6.1789799304735;
        Fri, 18 Sep 2026 23:28:24 -0700 (PDT)
X-Received: by 2002:a05:620a:7013:b0:939:fe9a:6437 with SMTP id af79cd13be357-93bf551bb21mr31973985a.6.1789799304320;
        Fri, 18 Sep 2026 23:28:24 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedc103e7sm120834685a.18.2026.09.18.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:28:23 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/3] rtla/tests: Show the command line for failing tests
Date: Sat, 19 Sep 2026 01:27:55 -0500
Message-ID: <20260919062756.819701-3-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: c5dB7khAxHO7wvm6qKgtlMYH6rx2riIYTxxDtlwx_ss_1789799305
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Make investigating test failures a little bit easier by not having
to recreate the command line by looking in the test script.

Unfortunately, this doesn't capture variables set outside of the
command line, but it's better than nothing.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 4fe7bcbab8b7..ab4fa0a8ded7 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -86,6 +86,7 @@ check() {
 		else
 			# Add rtla output and exit code as comments in case of failure
 			echo "not ok $ctr - $1"
+			echo "# command: $RTLA" $2
 			echo -n "$failbuf"
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
-- 
2.54.0

