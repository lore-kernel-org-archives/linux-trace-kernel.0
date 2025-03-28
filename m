Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8C1DF986
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187158; cv=none; b=BBJcgeRMo0hSPceXfZ/kunKJp3IMbYOF6LdbfAvC2c4NAcBjxqKw/T9rMIn7dC+GASXoQIPqYiiBq1oTBdyBO0p2ouup1YhBmWCWzk4cVJ/Dzhbbm4fn69Kasp1qoI6hgDzL/3oxhjnBs4rANmdtDJs4IN+U7Dzr0C/mIjP0NS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187158; c=relaxed/simple;
	bh=czbG23Aa50YI/FrxMSLQa2h4iofZTF2kMV4rYoe4N9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=RU4s9/2jAvWPo4cIS6NxZClkX+mImgPQgm2e0jOxKkIQxku4nDpkW6AtMSAb2Zk879GOUERIU92tOYCajMUGuV6+Q8mnSkjMz9339xMq/AbOmo8fXF6qEm5r+iTrCaTXBVFwJbAP4cB7HBpLfqHtcxmtWR+YOpBTbotg7FBGXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8SpLM6U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8SpLM6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743187154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SJKuNbmw7oC7DLUdI0HGCSgW0+TPW+f36kbISYsgi4A=;
	b=X8SpLM6UwDQibXPLe/iHJTUER0lgKCIPAyyk7Nt1aUwpTAGlGEQuKPTh2yP+WRUX1eFkwI
	aounYQ/7/QWMTlWiPsytzKvsq17vbPs+p7fJrNfMNsGJT/riJoBssHr1YI4a05DaG90TEc
	LEGexG+TOM+tST8m6hCT+3zefEGBK5g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-oZf8qQ0aOOOp9nSMDPlszQ-1; Fri, 28 Mar 2025 14:39:12 -0400
X-MC-Unique: oZf8qQ0aOOOp9nSMDPlszQ-1
X-Mimecast-MFC-AGG-ID: oZf8qQ0aOOOp9nSMDPlszQ_1743187152
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a3ff7e81so415440585a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 11:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187152; x=1743791952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJKuNbmw7oC7DLUdI0HGCSgW0+TPW+f36kbISYsgi4A=;
        b=D2RKZ/J+bZqmlwlSoteTt8iKGa/z84XMNm2iUaWJDFHuWgTXM22pDX+5xJMY/tOw1m
         VSIrhlItZsTzbnasjV69pUIWythElk2Gwnw4DnH91ZO+VwINJYji8O4tPJrOKxAN+ccg
         wUT8Z4nkkFKLGJ5BGoGIDm1+coSHCn2HtWv9uaen9ezZ7V40lJ00uwXp0JCqXUVhH6kO
         gW3uC2cBgAdvjcwe9JmkHtC92k99MtmHS6zpD1MrbUmkNVNImnOnsz5MfmHhzW8nvfyW
         ldgiHedmzxAmAW9A2A+62NnOxgkFpYf4Whf+AC6SDXeE7rTPkKj0cDHxmsqtZqjhkPfQ
         9YGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz1FVrSo2cYTYc8roYU4k1Err4FJAFj19gfzI2vz0mOmrUt4tM0iD5FxNQcTFmNUmm0vS+9dBJwVdKt1iX2RA5TiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5D/bRvptW5gcWE6YGErsa1xdmtiPC9s8FHixIsosNSOTtEXZM
	Irupp45erinPupb9n+9UrI1WDiO10q4ItltaI27Alwx0gM/Xv3DsUkQy9F+w9tb5sn+Yu/pT6fP
	QonaDjypP1DpTIl6iewWGNOoWZdn1CWVR7IzrgYbSxziwIhgs+hZNUCobaqVpgDjNNtfdJw==
X-Gm-Gg: ASbGncsdu4rsSfJQcPEwQZ5S5InZO3/UrbOHqtk7l6rTJ74U17i1bFRGVYasnjqVwAQ
	3YIMpGm/q74qeRx64rTYw1FOz56M3xCAyIyjPXWfWbFg+5onKkvA8klK9Dld+yPuFY4UVCRedMZ
	aeiNyUQuUUS2cGwtzSabsin5oyLGoHmeTN23nAyqYb84wyGgClJgviBJNejlrQzgdl22a6k0yO0
	+rprvCyuUXmRcmLNimozfuPxFd3hqcGEpF3N0x1ECsAH2OnYJisv+jddc5G3bWY67cZV+5taKwB
	qSBWnnGqOHsIkeNdeeVObbsZw1LcvEhTqgnHOyREYQ==
X-Received: by 2002:a05:620a:4555:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c6865ea80amr18436885a.23.1743187152221;
        Fri, 28 Mar 2025 11:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0/tGQn6PX+InznZllOicvlZFfe9sFTdh8a9j3T7npXQZgGX61Q2VsneZY1EaUJsIExkZ7GA==
X-Received: by 2002:a05:620a:4555:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c6865ea80amr18433585a.23.1743187151806;
        Fri, 28 Mar 2025 11:39:11 -0700 (PDT)
Received: from x1.. (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec964649fsm14276836d6.40.2025.03.28.11.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:39:11 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	aruiz@redhat.com
Subject: [PATCH 0/2] tools/bootconfig: allow overriding CFLAGS and LDFLAGS
Date: Fri, 28 Mar 2025 14:38:56 -0400
Message-ID: <20250328183858.1417835-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eQatxoZ2ywJ8HTyXmLIAVZ-4qotxlwSg_o9BwYzrHmA_1743187152
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Allow the user to override the CFLAGS and LDFLAGS similar to what's
currently done on other kernel tools. These changes allows bootconfig to
be compiled with the hardened compiler and linker flags.

Brian Masney (2):
  tools/bootconfig: allow overriding CFLAGS assignment
  tools/bootconfig: specify LDFLAGS as an argument to CC

 tools/bootconfig/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.0

