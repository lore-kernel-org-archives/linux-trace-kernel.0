Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD302DE704
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001350; cv=none; b=H4Y223i+y/QEZJdR+AMj9jiRHTiSOVCT4qzVZ4aUUTH0BPzT/BpQ+c6k/P4oF+UbQMHWzTHHT24Ftj6uyOpWzobFlzJQmquAumHHMOYpP77qYMbKmeNspis95Ma5jkZIl++1CeZTHZyTODMtyhAybAWJ6rRrG4tT9p8vLLw2/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001350; c=relaxed/simple;
	bh=GCQf+fSlRoXWlrGzxejOS59aSKVCoeuvh+mZuQCTo+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaGi4foO53RoMa1RX5AyAT2iO48dxq0EBvCUCHcTEI/IhmwzwzTJxpcKbZjCM15nqF+MKwgBJnh/fod6ir6Naopf3CFzm/WsrkpkksSW5HoySUd9GFkq5HCCAOeGT8R0ah77Lw7jusBFl3TMmtCP1wFurHEEMNPisVoZLBhRO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM/fyGzH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM/fyGzH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7742adc1f25so3447972b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001348; x=1758606148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JEHaZ9jq/KrcjOhCPcE4D4fEK4s5Ukw4ZA9TW8oNXo=;
        b=SM/fyGzHXgmiYo8u4kQIBGF1zOunDjnHlB0OV1kto4pyb22PEh3TdeSjIBESE6lGGu
         KmtDez5WmcpwM6PL44HzTq7GcvBZNShAxgKpT+/siSPbxmH+AmF+mX9B9hoeKmHL9kKQ
         rjCEn6OSXkvHWCZoqnq/U8gCy3inXT8GkRB02vrMPMIYnwnYpvpuhICILA66JAmjiDxV
         AS8nwuAIEeKnHJBJh14O4J2dusk/UJ9Osy1lf/UlQWz+ohe/xw58zdrEP4m3mvwjaiF1
         O6fNHfNGGY1jLuJBGzMLAN/p7qKvLphEaSlnWYaHKzv6mzPe18QLm6/W+7w/ggC+Hy7c
         Vd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001348; x=1758606148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JEHaZ9jq/KrcjOhCPcE4D4fEK4s5Ukw4ZA9TW8oNXo=;
        b=boQAZmGRBibyNjcyajiSQkl3/Wl2Z0iL64Ai+gggQ2h3fiiCcmUGJqJxk5oaynHdaq
         LKxAPBlOsJL5zWXgHi/eu+mzxifM4B/HyySxZITKGvuPoHxbYtm3wWmqJKEe+Hf2KoWi
         WWtO4aWCA/NB6AsQLIpFq0ICBRjBwFibSYS7diwBYCf9Md70vKBLgsaNcXM0bgp5oXW5
         gBSSsEFp6X9qm3i++ivlleGzfT+4Pu6/7zlh12/tknppWYvG+xUbMJJr/0JdEzUqEUHm
         KYLcU1U5qRoYjuOTvj1z2laTgwv2N2RE4lrGva1PAldgp8O6WLEhD/LSzo07aB3SJRvS
         yZgA==
X-Forwarded-Encrypted: i=1; AJvYcCXNKpoB9iFRTonKI7CQA/Qg4+kYTmw2vVPP/FkwnaPDzgLPNt6TF+QK3RhiG0c05FPRG+kafRcYzb4EEvGXWZP6Crw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3TqmH0nr7yHbN8b9C4XdGRejuG7rADFsOv1lnswbu9Svs7oH
	4T+KxxTtYo4ugv3vKfNaUwTs0cSdKI06ug+Qu2HG2DTLfOXY1MvNzm02
X-Gm-Gg: ASbGncscr78pTfzFhKxsMhPS4EZXC+OB7Rw/+GrwNATWGNfENCS/uNoW0o9wvp9TeiE
	oPpCdho8Y8td+j7jJCoYn50yPRZkL8DeTS37id1Qd4fGYjtc70+LMK7CbdWAwVSdF+9d75i4eRs
	AL3SJoZ9WitTdyjHyU/c7qdTlZ8eaSkVqN5mJyoYjVUvThAaUVx3JJ2jXQlhO7jWxWpqtQkDbUp
	vkjNirvDLt7GpsF2VcbDsfgGp3Q8VkdgZrnas/dka52V/8BY+ACrP65fTTydXUQ+I+XHfSPFYiU
	egFXDKsn8Skg1iBss0ZkNZtysy2YVcEx+GBq4Glgl/DBjkGeFWTweNafB3G+DSn0d4fzp9CQRzE
	9HxgpCDRtbiY4ZxuVm+ewW6cQQw==
X-Google-Smtp-Source: AGHT+IH2awkKQxguyzU/uwVtBqGOg3ZGaTcFUil9iVYCCLUicJLX7MvepKfcuJU+DXVC/gjlgfE9Zg==
X-Received: by 2002:a05:6a20:14a4:b0:262:1611:6528 with SMTP id adf61e73a8af0-2621611681cmr9714164637.29.1758001347998;
        Mon, 15 Sep 2025 22:42:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32df315f9dfsm11822877a91.21.2025.09.15.22.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 97AF54227237; Tue, 16 Sep 2025 12:42:19 +0700 (WIB)
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
Subject: [PATCH v2 5/5] Documentation: trace: histogram: Convert ftrace docs cross-reference
Date: Tue, 16 Sep 2025 12:42:03 +0700
Message-ID: <20250916054202.582074-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=bagasdotme@gmail.com; h=from:subject; bh=GCQf+fSlRoXWlrGzxejOS59aSKVCoeuvh+mZuQCTo+Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfpizHYkUTnk/IZ7D/nWJo3ycU5jjTR1Oo+W3/Tp9z j8UXlTUUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIsYMDI8rDyau8S8y1QvPens nXDVtwE2C3yYpl3XeLa3RdbnqPM1hv8FL6a/O23a1cgSsatpmhBnYYbvEf1Eb7f1mX+0951auIQ dAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

In brief "Extended error information" section, details on error
condition is referred to ftrace docs, which is written in :file:
directive instead of a proper cross-reference. Convert it.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index d158dadaa42447..340bcb5099e7a4 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -209,8 +209,8 @@ Documentation written by Tom Zanussi
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
-  tracing/error_log file.  See Error Conditions in
-  :file:`Documentation/trace/ftrace.rst` for details.
+  tracing/error_log file.  See "Error conditions" section in
+  Documentation/trace/ftrace.rst for details.
 
 2.3. 'hist' trigger examples
 ----------------------------
-- 
An old man doll... just what I always wanted! - Clara

