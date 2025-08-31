Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3B21CC5B;
	Sun, 31 Aug 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635508; cv=none; b=Ts6y5gjNasM7tmRfytPsrEjcZuutD00aTDVU1vzEN8pMBbfLaUur0X9VpGNgsvw1r0J+uO7DuEafTHlwJNzNrE/Q/X/ODb+6oK/57SQLYo5NamjFLLiwbQ2kxjb63JjNyquqcNFkg2zz1Io77jEcGDMov9Gb92djTU5lYv5rtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635508; c=relaxed/simple;
	bh=c2RgDDu8j7wlyLwpBe1ihWu4sGXYeLTN1vrm4MajVac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0qnGlRBEAZ8BYSH1V0wjL6hsNLQ/Kvt+VJI2rmrttWm9JBb6jcZUxFFLclS5yCoZSTt5MM90DT0ZEACti55ff4AVh0vwEs82Gz2Is2IQqwKhwAFeOPameMLRkecDGF0fkh1BNUufV16NowAloRkXNV3D9VtjACCX4D99T0gVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqxfrYfV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqxfrYfV"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b33032b899so1349331cf.2;
        Sun, 31 Aug 2025 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635506; x=1757240306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OsZBUlaMD74NHBJiDTCM6ecGx0NSFXSd/05ja+XFyc=;
        b=nqxfrYfVfn8oGOQxR9iOCPpSYdjAukJ2ZiStlGOf7RtadJcHfRYsPcXo8xqNDfs/UT
         OEQHlV2JeHZV34UeBxWwjgMk0pw+x+6S44HRowPQJdftAy6hCQuWfUfCgQIOvTNicKj1
         1K/IOKtlevqyjzLmVywnPKiFPgM9lTDt5n4hfrQoBLjHts5N9GJd4iDjvYW0KEi/8o0S
         9M0AjEhwDHUZfm5xALQi/6dyeBM6vDBMcg945rjC2t5cDQf9o84JDqVXcNrDY+AaHnhb
         MXMOWxRcnnZPiAHt52Qa6B7wW+LelP0nMfYMQ0f5x2F1pow08IF4eaVyhhfLgLG5erBO
         vvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635506; x=1757240306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OsZBUlaMD74NHBJiDTCM6ecGx0NSFXSd/05ja+XFyc=;
        b=uRr72wnB+nGRPL12cZicx97vQ8pUgD4TBtWOj5awdmBuqprTsGEXnXzhCqfxk5tjHj
         IpueRRG9aJ+0mtG0OI2VDhRVGumdY7YnAfr+EGQXqNucEwyzeQuLGZlUaY40rklozPJ2
         4W2DCFe4gf5FPCWOIdFn3Pu1hMpE/gPt5zHzDcMLSqu62gsRmkyHwNJDJYdlZCW3p2Rs
         z/exkEfv2PrjRZXcB6s7uLmx/vfxZSS+f6Mt/EnFDtC8Sf5djUxugdTFdwetdCxYtC05
         MetavPbJUv0+P9XrAIjTH+47Ut6FRd9qPTsvnzpL5wvkYjxUfnqEoOZtXER9w+9F/pV2
         +VmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL50KchpFQtxLZ9Xky+WFuPuyYQ8lqFqXt2S6OJnIEqitLQyNfVNBXD8dmEwkY3rMZXGcoDm4fveg=@vger.kernel.org, AJvYcCVB2lf36DS9d5ysyzYfEgaOg2QZBOpT+oIVwJxCiQv7CrBCtGAZ5T9gQYIRE+uIkajWb8vGi2zbq6juC2Z4CbecceM2@vger.kernel.org, AJvYcCXvc7t+9MLRz18+T1TGw7JiYmefcF0u7dlIMyWQBsAdzGMtz0wF5k0Pi9fZIc+b3rfVvNMbUYOWku8YMXKX@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8b+tRA1QhLhS5T3tlkSWx6dBNOGQlzIkYiDxruH+SExDN96p
	e3WAy7b4L8RDa7zITSam+PPirmExws2NioACNACs8EAjeXv8k1n2Ilha
X-Gm-Gg: ASbGncsnGj3lBnqLkEG1co2WZ2htHzqbTbiAop3MVzP9cCsPorVCo0yNNDSZOAvlwP6
	hvZk4beJa5OHV6kZ7lGMQTjdawjH0S3Uo2DeJH3c0YhHk+PP4RIJOcP9HhJMRFcfVckqtx0JM5s
	xsrd119e/yflgYwyBEC4hBwN14ENcjDb+zoFXAH4FTsKhYPqwf/wpls44ovjd0ED20rejHBBKLv
	oYo+/Z7BiiZDcZ7yf6AS/9EuCu8tOlv8qUmv6KfwbzsH2VnpF6oj2pVpNRvtHEnZZ7vFlfvZscD
	Vt341MQIQRlsg4AjLAJy51Qun8qBv401Okr0iCg4n3TfZJ7aWYeCCmpp7QnUHvqaDF4878fxBo+
	Chw7naydE9OeDiErdQo/twCs4YpKW7iFesfC5F9zCizkfeFfVgy76Etd6H6yWGi4JvqSqK2tkUz
	XCCQ==
X-Google-Smtp-Source: AGHT+IFCvVv30QNwduYDTaqdY8J4BmWG1XRqOERYPj74kTT4BTe3Rnu/UGjTkQ4sNO8YIES4qmh6ew==
X-Received: by 2002:a05:622a:1a86:b0:4b3:8fe:b1d with SMTP id d75a77b69052e-4b31d86e9f6mr46360931cf.34.1756635506213;
        Sun, 31 Aug 2025 03:18:26 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm480262785a.66.2025.08.31.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:18:25 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] trace: rephrase for clearer documentation
Date: Sun, 31 Aug 2025 19:17:28 +0900
Message-ID: <20250831101736.11519-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
References: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 Documentation/trace/boottime-trace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 3efac10adb36..651f3a2c01de 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -19,7 +19,7 @@ this uses bootconfig file to describe tracing feature programming.
 Options in the Boot Config
 ==========================
 
-Here is the list of available options list for boot time tracing in
+Here is the list of available options for boot time tracing in
 boot config file [1]_. All options are under "ftrace." or "kernel."
 prefix. See kernel parameters for the options which starts
 with "kernel." prefix [2]_.
-- 
2.43.0

