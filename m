Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC58277026
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953579; cv=none; b=QHRr9QqM9pMa+Y8YGwTyT3yJOP+Yl//TmBOLC42N5Yhl1I4NJUXEabFojY+ZeminjKrjrc5TSav9h9s4/LRCBLA/GYTuPVSGwxd3P4/d/rfY8XxoMhrKmN0aR5d8NiSZNebtGDk5huaZTdipl/343x6UpW83/f+kzzd0PtevltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953579; c=relaxed/simple;
	bh=lnrEKzHOYdxbMxx9t78Bx8tEtDr03iuoV0ODUkIlfkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=X183Cx7XRqiBFgsQwyAxhkOLbXdbLoPnsJ2SBv27D3cbVYTr7CH1Np0wNoeWPxyrrlIcH7cxxkqziBWxWxNcQeAojggAsPa5KKvjzYkVZlNwWNeSAUr7I2HezAjoM8HAV1pZR+osnySLfD9wdq/6IjxcDwToDsFqicUsQZg2BDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2Ey8MKg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2Ey8MKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5vmiHk+8zHsqmOPIZRro69RF9ZYYZvm6wLS2qBi/vW0=;
	b=R2Ey8MKgnSPmc+WmMSn8hfIbxHw5+SvsuO4h2XA4uNy10JHfwx5GbvwE2rZbFXcMeSXuoB
	L9/reYlAIWLnlJWJR46m1zwRNCUwY7iO2JtkrkaSzLHKTUuzyHfyj2VjqILamyAg4InUoc
	IoTEqXZgdIwRHKhWG6a+mqwUxt7rFD4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-UkbLqAAiPfC4sFL0-O3qQg-1; Wed, 08 Oct 2025 15:59:35 -0400
X-MC-Unique: UkbLqAAiPfC4sFL0-O3qQg-1
X-Mimecast-MFC-AGG-ID: UkbLqAAiPfC4sFL0-O3qQg_1759953575
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42558f501adso458817f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953574; x=1760558374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vmiHk+8zHsqmOPIZRro69RF9ZYYZvm6wLS2qBi/vW0=;
        b=lsd2+TiFkAkVTYdg7h2VhZUsNIiQFQmpPxHH45bK0HHNf1q5WvI2vx2UzAjRhzABrk
         9sO5GfdYFNQqRo1oti7Hfc1Y9rKBgYq9kazC4DEsQaFJ5QrJnOhdbZmA4dqNzvzlhOi/
         pPSi7tlyPzjPGUs4dsYezaUNEHhX/ZkYXiuruHNY8VmHbosI63jScLNv7DehTnWA5awZ
         fVJq+kOdWp0PrvtUvVBd4DQu4DPR+jM0t7d3MgF0P7li+OYW5/RMlBIim91qQLJQXwZy
         RZkIlhtHs62EffTaznmQ2bYCKysBXXUEgYEpv9mOVmDm1j31QyVIDagrz8rdI8ZGQCbD
         R56w==
X-Forwarded-Encrypted: i=1; AJvYcCXjgRelzinPNleI/N3IeulXJuF8Xz1A/nbhRHUJ0O1Vs3g9F/tgzSEJXXEMU6s9DvN7C5XOxEtGgKy/HL60w8g/fBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1X15f7d3fXrfmzQbR/QwRDGKPheMBTCCE8A6H/WyFcgrT7QME
	iVGdu/7D/rmHSV2DgBPM45fHcqfy5LoSjIxpVb23j53O1Y8inC1JiiekRqamzo+oDNPdOwZsB1X
	QNCOozOEqpopJH9nDxKTo0mUG9Suus5fuAzqTILltAfVCroo7bWc/Sd2p5d6x+SWWSYUfyRbnqw
	==
X-Gm-Gg: ASbGncvaRqD4wGEvw4QAVr8598g1Fc3mctpkn85STEYsHktEPTOPowD6tq9sskPqUPx
	sXSEai/ml0c24xS43Ytbl/TrXiU56C+2edZv9Fp8bLqH1KEbTDq02x+zlUYO4OslmnDbFBrSPm7
	IE7zlsLjq914O6RGrWxpC7xL+/0JhExGpuP3TDj4vHrDdmi1b2tYmBKR556+zWbF0RCyyuR7rO2
	BuSjlPnPG2+ge2JNvXA/klAtJCVvzLo6+rBSNv4K/4+v3WK3odejpCOu7lYHsRwEs0aNG7ZrU9Q
	OENmT4doejNMOi2RDRlcrrAI4ScxJVhmxGsFZg2sY2JJcqZwyuDKjdgiWAOZ1UE=
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-42667177c79mr3125789f8f.16.1759953574610;
        Wed, 08 Oct 2025 12:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeDk1T+mofjbdTeoqZInB5e6nHlSzZa5o4r2OFHcrqzydR6gR8O3TlE5Rv6mr6mJmuJuRGPQ==
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-42667177c79mr3125777f8f.16.1759953574226;
        Wed, 08 Oct 2025 12:59:34 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:33 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] tools/rtla: Improve argument processing
Date: Wed,  8 Oct 2025 22:59:00 +0300
Message-ID: <20251008195905.333514-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Onq0Tpa9Bk_cmtQNLzDaZAMYa-mj31LJ6CYmWaM4QyA_1759953575
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The long-term goal of this patch series is to reduce code duplication
and unify argument display and parsing across all four tools.

Costa Shulyupin (5):
  tools/rtla: Add fatal() and replace error handling pattern
  tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
  tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_top_usage("...") with fatal("...")

 tools/tracing/rtla/src/osnoise_hist.c  | 74 +++++++++--------------
 tools/tracing/rtla/src/osnoise_top.c   | 68 ++++++++-------------
 tools/tracing/rtla/src/timerlat_hist.c | 82 ++++++++++----------------
 tools/tracing/rtla/src/timerlat_top.c  | 76 +++++++++---------------
 tools/tracing/rtla/src/timerlat_u.c    | 12 ++--
 tools/tracing/rtla/src/utils.c         | 14 +++++
 tools/tracing/rtla/src/utils.h         |  1 +
 7 files changed, 127 insertions(+), 200 deletions(-)

-- 
2.51.0

