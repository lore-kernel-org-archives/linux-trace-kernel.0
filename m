Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAC22154B;
	Thu, 11 Sep 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564736; cv=none; b=dlZvUne/8ozGIFJ1yk3JoyJW25+e0z7pt18Zy1OI79atmeoxnxjxpQ7fewpEVma4kVbgzv9IHBIoJWy2568ys+ATcVv8CPO9D5rze9+lbylamFO2A1l1txi1ImaA5JHT0EChtksr4/ffQ6g9VNx812HUNZGYxH6cc7W7v8Hpk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564736; c=relaxed/simple;
	bh=i+Pbd3ed1l2DaP8gstdwW8Ty90I7SiYDYltxbpd4oLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbdO4h5n2MVJT0va+wcgN3ngwr5fx0VO8JIT67MsYnugZM9AFWqH9BOY8xqmzg8evsyGdBnkH3/LXMeGOXIxq7VxyWPtprAzNOZHOvbLdlGZdNHYnGr8F+07N1uguQULF6B+dVyc+lLt4skyfnXoh7QL5uj/u6IoELP3E7zCX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8hqpOtY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8hqpOtY"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so195733a12.1;
        Wed, 10 Sep 2025 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757564734; x=1758169534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEU07XkMyVIJTgqm7gIknyaHnwvqbGQwdy6fIsQ8kMo=;
        b=Y8hqpOtYJwPg6dw4uE43qye50XlCwN/cFyODFB0dAdkgcY4phP7ruSWqNbLRu8h5v/
         mLltf9UWZ+70nioVaHIuRiVEcFfwcG/4Ii6GRlcl9M6dR3FUx1AuSaRgJubSLNembyKd
         bD6l6yhbMPCUP4Ph7pWcG20ZrawXINzbc5llxAuuxNW7aHOpe0iLo4pY1wz9r5vjv5HX
         xYFjxyGZ+KIBUmR0GAl2Mc0MWwSC7Re0Vto4g19Wuz4WgG/RYKotmHyWhb3aeAWnZQ59
         LrxUPuePOwoXCy8nlry0+YRyxqw4it4OQOpg4JzH05Y/MPJzKAKL/KyUyG6DThtCWToN
         f4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757564734; x=1758169534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEU07XkMyVIJTgqm7gIknyaHnwvqbGQwdy6fIsQ8kMo=;
        b=A5UNIj9yPlK7WQtiIjlmwXtAKPkw0oBuMKbYsL+uJRm4uKVDfp3DC/T3sXPkuH2BDg
         LO9sL/g79UUDWB8UZdaSyTiRmaKDVWboOQxEUO6x/Gcomdq71zqmt9agCOYsOFL98/et
         mH7f4mjfOYaHOX3fQy2IDrCbirb1u98csmuqovzfUkYdVKRv8cy2ec8xftLaE976VOBS
         e7slpRvHZNf0yGq8MU1f4wMks16HrFvhygLhy9ZGCvExnraH++kB3wYHKIfyrLkAQej6
         eVtSrnrSzGew4P6KAUm3ODVwbkmAr0STMcM8g7pCGnHk3ZXpASMwvHn2V6PMm2LwQU78
         8xTw==
X-Forwarded-Encrypted: i=1; AJvYcCU43knw1jh5GH5XNWlfvIX7nKxzBrAGF3FEydJBTEiRrYDP5Oy+w/3cfafT5B20T+X7D3qpb44iFuo=@vger.kernel.org, AJvYcCXyK5YFkHbP7fj6+gVvfIijCDzIJmBLDUqRoKCmC0U1UAVVoBCGTEDHbaRbO6Dce1xvHOhFx98GC26+qIGXbdcBL1Rq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ncSd0mi7aS7IAsnbgbnF1revUsUdqYqulIQ5TEubHQ5O73xB
	cEe2oFyfHFTDmF7tnj0NZCCK3VECeX7qtn0kBJQ0+CoLEr1jtjuoKn9a
X-Gm-Gg: ASbGncvaErr2RN9MC2pw3HicDY6chxS/2sn5J/rqNJJTi1JDcz1AkA+JtkVqqr1iwdI
	NSDqeHQBwRzugPqfVPsi5ojYariTeEWrwrHX9LlJFhnZA64Wa8xqrdfrbuVd1jyUAHUFI7gnvsq
	0ikwPu3F2DEc/+qhAzHowYa4d/kSX4k9yJ17DPupg5RABj3loEP7n20WQ/WVRuJavUq0E/EVF0m
	2veDL6DogegT9rrIvC47M/LFQobwLxUS6bkt2gfePx9yxR8fU2XIcOxFGRo8Wb/9Xl80DofiwnZ
	bxgBoHtPJ3hyqZdZRFwICcdLr6wNZ/eU5+eOPP5EsrPlbw+8Vv6olv1CLESGZnBdoclp4cTfgr/
	Te/jiypBOq7t90XxKNyNPuz9ZX/lgwijxrfHo
X-Google-Smtp-Source: AGHT+IHMPhDfUxV59Ud3FN4JAx/KKpRACSBgUVLhJ6Ucu/BDq+VrUSCOcGJ1T0eBVj3XxMrGYQ2xrg==
X-Received: by 2002:a17:902:e850:b0:24c:784c:4a90 with SMTP id d9443c01a7336-2516ce603famr247383155ad.1.1757564734298;
        Wed, 10 Sep 2025 21:25:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae29ae2sm4045395ad.120.2025.09.10.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:25:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B0A2B41FA3A5; Thu, 11 Sep 2025 11:25:30 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/5] Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram
Date: Thu, 11 Sep 2025 11:25:25 +0700
Message-ID: <20250911042527.22573-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911042527.22573-1-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=bagasdotme@gmail.com; h=from:subject; bh=i+Pbd3ed1l2DaP8gstdwW8Ty90I7SiYDYltxbpd4oLQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH/C4ovNKc8Cn78jMZ98Z1Yf/rvV4Eqmf+km/u+579r C73OH9JRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbC58Dwv3Zh5fuzwupzm7uk bjZNX84RYz8r/8LjC5wBmz8KL9B7r8zIcG/mTtcYc1mrN32sUm++uiSkrfBfJKzrx7rwGaf9nk/ nGQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section heading for sched_waking histogram is shown as normal paragraph
instead due to codeblock marker for the following diagram being in the
same line as the section underline. Separate them.

Fixes: daceabf1b494 ("tracing/doc: Fix ascii-art in histogram-design.rst")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram-design.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 231a12bd7d461c..4faff1669b77bd 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -380,7 +380,9 @@ entry, ts0, corresponding to the ts0 variable in the sched_waking
 trigger above.
 
 sched_waking histogram
-----------------------::
+----------------------
+
+.. code-block::
 
   +------------------+
   | hist_data        |<-------------------------------------------------------+
-- 
An old man doll... just what I always wanted! - Clara

