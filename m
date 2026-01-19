Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112333CE8A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820356; cv=none; b=TeYOuILgnxcYQIitIT6LAYKiaDPHl1SSiqvlpChx9KG+uEHiI1ZykCAHAGT0SgmVx/Rwir2agQCLsi/IaJ5DX/2gjQ2RQSzZIo+UdRekfw0VJq6YA/OdakEwo6UzSMj8AuIkAYSlOXAGO5eAP4loBXy4OS67fwHHShKPNCSEEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820356; c=relaxed/simple;
	bh=IYxM8cWoTeKECwHlqfYvlUuxrpcZJHZrkwx5sGS6mGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=MFhSfJPjvQzXgJCTJ77LbajF2WmSnv1Z6e7Z+gpFic39q9pq1BlE0nwco/6/hsKuMHx5Sv/oi4cmhqQ34QD4r9JoqbsW8y48s+5TuotgGN/uQ9XqRawYGtwsQPeuiWAinnv93jnzlrJs05rvLTeiMBUPfeIPWKwFs8kWr8Wiswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5VjNbzA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5VjNbzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768820354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PTvPCqDoUp1cSjrDXhisSvGlwvpu7tya5IpVk2EVoYA=;
	b=U5VjNbzADSTMAI9PsbB4z+SCTqbzglh1JgJH8lY4r2Cqm6i9+j0pLoevdHPM9aORpY0ca1
	T6B3gOQVGpcAlITDSZg5wQ2m97bNjqzYoqmavR52zP08/J856jHbxvNLMPQ92MaUjg8m+S
	RtVvkkMwuim9VbgxxLYi8p20ZuW1cgA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-H5wvhg68McGfPy6CCfKGBw-1; Mon, 19 Jan 2026 05:59:13 -0500
X-MC-Unique: H5wvhg68McGfPy6CCfKGBw-1
X-Mimecast-MFC-AGG-ID: H5wvhg68McGfPy6CCfKGBw_1768820352
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so53087645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 02:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820352; x=1769425152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTvPCqDoUp1cSjrDXhisSvGlwvpu7tya5IpVk2EVoYA=;
        b=Uzk0Nj+xfLk0A9ODVhv3LtHQn9xRnFamp4ucY3is2CeJPeGzcnxRoB4ghUr5BM6mN6
         iv/TOa78BcsMf6CkxB6/O2Z8DqyhLrJnpcVVl17Xpcyr87c+WSwr9LOdwxA5G4hsz1Zm
         /h0QNUf/xxjwAbh2fPwvek4xhPueWMGDqpKbUF2P49RSqXRD/mTEJS90hM3MWQsLH+NN
         hr94YX64aQw7Tm3uvvqL4r5xkx9YPi+9u0fYzxUajHRqhJjSu4YpVCj20Tan1TMXhy1s
         o7ycCtRTL5Ns0dzEzXmU1WVuKUDQA2PGK/ly2fN6Idv4qrG82CF0yBCiGSo/kWMI4Ga9
         IjWA==
X-Forwarded-Encrypted: i=1; AJvYcCXrF3fQVq8BUtfUMQwh33c3ZoV+LOQriR+MDcg/67SVLe/ZjyWq3m/0sp/0mey7fr8EQg5Sb82koxlngDUWH0tQF3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmA+jOebSGfvgEWZTWZv0i2Jc+PmWKXwCjenNHNFBfQAdkGUnZ
	NMutsiOAlBfSdg7h2tjVzWfnlOzIeCsGcqc/6TYWwRuxjRBNwdh+VKJJq3uuhtVCwueFvv8ikxf
	IDD9Rjz8L4wH7u0c0ebGLBQw0hcAUd4pnHdl69szaYKj+WKIQUPW4FVepIKsJ1+V2v0x27FnozQ
	==
X-Gm-Gg: AY/fxX6ptL4kSSUn47q2hJoYhHRaQHWdYNpH38w9hMG3CjmOvg3A7kYwTEWOrLCS2uv
	0MaopTpDPPJrfTew/MKDw4zdcyx/Bje6DokE+Ov6rx/IAzvbwd5N8n/fP8prYgUZn+FTuDcH5my
	1vG94hc3GYdiuDSHV7vPgDR55nGSei4orrxlgnobJtAETjRCr8mD3rlg8x0MHZDGE/qpxmRKJnj
	DKrSvUN2hZQHUfomNzvARKWCrn9CZ1MlnCB8Y6he/chXwa0zxIvQv0iVSKxcJwkTBgXqULwWBuP
	2X4jnYDN3V+fDlZyaMpvKueossk8hwpMrpuEMQHVMU5+z8lUptHXikLwdRZjvOER1I5hzWjZw0H
	bFx/Dwp0i0QXMbFm49JkLyQ==
X-Received: by 2002:a05:600c:3d97:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-48029b7db7dmr78915415e9.10.1768820352006;
        Mon, 19 Jan 2026 02:59:12 -0800 (PST)
X-Received: by 2002:a05:600c:3d97:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-48029b7db7dmr78915125e9.10.1768820351574;
        Mon, 19 Jan 2026 02:59:11 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569922032sm23320735f8f.8.2026.01.19.02.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:59:11 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Blake Jones <blakejones@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tools/rtla: Add unit tests
Date: Mon, 19 Jan 2026 12:58:55 +0200
Message-ID: <20260119105857.797498-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GoxYAsjbIErE9E03NH_B51ch73RB4CST5ddKhi8jGnw_1768820352
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

v2: Address feedback from Tomas Glozar
- Split the patch.
- Extract separate target unit-tests.
- Use build system
- Add libcheck to tools/build dependency detection

Costa Shulyupin (2):
  tools/build: Add feature test for libcheck
  tools/rtla: Add unit tests for utils.c

 tools/build/Makefile.feature                |   3 +
 tools/build/feature/Makefile                |   4 +
 tools/build/feature/test-libcheck.c         |   8 ++
 tools/tracing/rtla/Build                    |   1 +
 tools/tracing/rtla/Makefile                 |   5 +
 tools/tracing/rtla/Makefile.config          |   8 ++
 tools/tracing/rtla/README.txt               |   1 +
 tools/tracing/rtla/tests/unit/Build         |   2 +
 tools/tracing/rtla/tests/unit/Makefile.unit |  17 +++
 tools/tracing/rtla/tests/unit/unit_tests.c  | 123 ++++++++++++++++++++
 10 files changed, 172 insertions(+)
 create mode 100644 tools/build/feature/test-libcheck.c
 create mode 100644 tools/tracing/rtla/tests/unit/Build
 create mode 100644 tools/tracing/rtla/tests/unit/Makefile.unit
 create mode 100644 tools/tracing/rtla/tests/unit/unit_tests.c

-- 
2.52.0

