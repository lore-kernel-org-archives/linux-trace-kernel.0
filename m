Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DB2036FE;
	Wed, 16 Apr 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771275; cv=none; b=iBqmizxtTpT88n20pfWC3EZNLu+hWvhEVAv2y6otUBCa6QR4AsBt+1mJmtslMEjVZ+CI+Ugt3lgdSEGLL/FlW67u/X6qhWOdWlf9Aro2MhAO+oVdcAYolC6hGIDA8B/w+N+XFLUl1UZwEKqDSChgKbiL4bO9iPu/C1mc4JjmW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771275; c=relaxed/simple;
	bh=FkRVXNKC+xRNgc/OogGMUQ/Jfwn+EsKyLG3NXD9DFt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqDunQl3KBN2spVegFlthkBHPsNrEyu1DgXpxnzw5Te7uqZ9VLMTJml/Zm0QE0npeY6cgVKbEpZxYkJ5Bm54LQpu8ViUY4JGaJkblu4Ep0XdAZKtYT0CNo4ZBmnBfKWHZJSbojx8Z1AJQttWF5/OW8i0P9weUQpisqfzt+jOIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfFYnB0G; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfFYnB0G"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c062b1f5so5300268b3a.0;
        Tue, 15 Apr 2025 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744771273; x=1745376073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz61i8qUAV8iWVz6x3ob8yDD7RMdWM4zec8L4BtHgq0=;
        b=hfFYnB0GuijkdfkCXvPeDhcCoMedHou9e3U4Ke9NBdlXOqVrP8N9AuIEGoPb/TroVP
         0tDjRze3xaSCIs94o2nND055RUlk8JbE4+i6+GCbQyD8pSquXUIrFNEnyEut5AeDbQT0
         8lhfzZv5kL1I/iSLoZgzygnwALyFsyOFFkIHL/ZAIAwF9RpkNjOq51RFBMaD2GOfOCN7
         /DyjwoHys66VLXcN5ZiYss+fY48OJJYqzjuNNvUxBq0DHF0ecRsDjp0mePGCBtnGFf7b
         IxfiQGBChPZ0YBPRRz5aarfTxIGjkC6J4/un/r1LUZczOW2zccFdA3bIBe4hr0u2b5Xd
         ZZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744771273; x=1745376073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz61i8qUAV8iWVz6x3ob8yDD7RMdWM4zec8L4BtHgq0=;
        b=NKzEKpCxnRrceSYF8hCkaXEU/mY9AW8ISoV6CdmIe1Eks5EeF+BRRdc+BTKSGOKh/o
         wKAYc2yDOxLGxAkynGjpOI3zkklnvSb27QphSd3lnIe0RvJaxm7YOKnuW/Jm3CZ/h811
         8eNQOPNfGitLRtuag8aUVitoWqSbcUzOGejSSSfmEXb3RJ6x1K79c4QCGLSlowxBWb7n
         hV9H3v8B3M/MsQ25qyJ4x+C2RSCv5w4ZP/54lu4PI1t80unh1x3Y/33Kvn7RwL9TM6U7
         qlcSwMu8rFy5uzD8XxCCqvVlSp7kg7Z2O7RrvztIou2eZDMzQP5Qo0vQQsQhsl8JurAi
         zoew==
X-Forwarded-Encrypted: i=1; AJvYcCUtMT5DXC1H+HHZ3OpGg5pUa9Jwc49SFN2fmRyuaL3zhi5yhy69mCE2hqZVvhbcbC67MIqEHN++9CinO5jjbH7TQOyT@vger.kernel.org, AJvYcCVBqVdNigffgehQtLNYhJCYt4QvObMMtx+UUpn1AbIXP0Vvf86yk1SAe4XI67IwZMUb2rdMJtA/lHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vE9QJ584XuJe9HWCkbGqwZhNgY6RJWFOgOyMSq+VW+lQEwk4
	5twqxT8Wgkxiek75oayJ2+X8C0L1isITgiOGLB/8ApvidxsS5z7Y
X-Gm-Gg: ASbGnctWRcvgzbQcilRBePCrt87cBF0NroztO6c7V47ablcR993/LhTHsWwcgWxLK9+
	PGErop88kFtLx826AdozBiZGD/WzrsSSO2SBdMKrUUgamcADYUu1NDW2KDlYNGq5OPkjElhS5PG
	79vXKaXgcchd33NaEd37tmr1Y5dBZ0adnjm2M9eGPVJAFpg/8KkkRCoZRbipS8j6xVUH+NRcHnQ
	Q38j7vNCL29+kO2gUW/pvZwsPEv0mES1RE100nIyAygyevc3grGpdECmdKcjl0j9B/d9CXeLP0O
	uJFZ53zEx+lxt7WmiXSnYrbiF7hHG4bk1RQIW8jM
X-Google-Smtp-Source: AGHT+IFfUEzNIryQz89qnSW6EHeHIDprzvq1Opi7prfrJilb79SQZ0vICHBxEkRo1GhqH48jZT4g1g==
X-Received: by 2002:a05:6a20:c6c9:b0:1f5:6e00:14db with SMTP id adf61e73a8af0-203adfb92b8mr2268458637.14.1744771273446;
        Tue, 15 Apr 2025 19:41:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230db26sm9585956b3a.134.2025.04.15.19.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:41:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 32F724209E43; Wed, 16 Apr 2025 09:41:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v2 1/2] Documentation: trace: Reduce toctree depth
Date: Wed, 16 Apr 2025 09:40:49 +0700
Message-ID: <20250416024050.19735-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416024050.19735-1-bagasdotme@gmail.com>
References: <20250416024050.19735-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=bagasdotme@gmail.com; h=from:subject; bh=AQ4ZMsp1WQ2xp62jywJ81Dto/a0A0hC0Yy88xBN79Qc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOn/xX+7R8fKtPW/ltjjKfKiV3tSyYO2/rP9lj93WR83Y zjzbYVaRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYSzMPwPygw5/otVf89z9OC uie1/f57wftX8+Wd9uuqW0q+7nv1TIfhf6GEKJ/MDsdoXWWtn8waTYuvpku8sWSXTzM/K/bjDfs udgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Purva Yeshi <purvayeshi550@gmail.com>

Reduce toctree depth from 2 to 1 so that only docs titles are listed
in the toctree.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20250318113230.24950-1-purvayeshi550@gmail.com
[Bagas: massage commit message]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96ace60..fecc4adf70a830 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -3,7 +3,7 @@ Linux Tracing Technologies
 ==========================
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    ftrace-design
    tracepoint-analysis
-- 
An old man doll... just what I always wanted! - Clara

