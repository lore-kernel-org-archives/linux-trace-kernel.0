Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795867089;
	b=WHaOZ9i7NrCqNGwJfuO4EbA95E98MhZW6aIaPEliggYTyfzevKdOfXxc/Z+r9S3vmEwB
	 GB7WmMSrwMxo2qqrsHAgYxZUyWJOE53hSi8ZsUbSdXSr2UdSgQhC8aofxdmm70N8T8ylj
	 oEEXBJjcYddvZ3XS5U+Aq5oWa92hyAR2hvMWvhUSB/u0ofhZu6yLi7VJyqVNphxfik/5k
	 3kLHifrE83EWOhDS7l6E98TUJ4ZdD9PQUwVNojIMwYD3OpjUdyiOQKLW7zh3UPiCVZ+xK
	 AP77z69ydLebz3NA+wFXTXShgEzroia6TlwZrLzG/xDMlGwlm75zU288uFVGv6SOkYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GW+E3bPc2TThHWvpV/0v4yXlrciAMENWcJNOY9IP/SA=;
	b=TN4IxVLlnVFPcxgM/Y7jJKR/cEzqwu1o7Mjdd2WfnPYKbpG1sVXxGhhCTxpFZDmjiDUU
	 mmqiBI3EAjXixDdZxPOJ1iblBM0naVb/6F0ffVojJtxi2vcFhZlqgdrkawcTQB1IATpH6
	 REdnhtwRqO5rblsYA9lUwuRsKdiPOl5hB7tWFrDPapStEqMpu1QHCTUWFuAEkfqGheHeK
	 g+D86v37Y3/yVvQxeXvf3y36GVVwEMXPM2B/KZmxZB7iiZIdVME5S+lCwn44RC/Dcr7l8
	 poQaZTT7MQFYrTPKAc/fsWRAUM2zJj8LEqiKHsrCoKWQpREJD7YMAh3Evh23wKk/0Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNkZEjnh;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86645606A321
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 11:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86645606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNkZEjnh
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so86820535e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 03:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795867087; x=1796471887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GW+E3bPc2TThHWvpV/0v4yXlrciAMENWcJNOY9IP/SA=;
        b=sNkZEjnhp3GTM4CXEAQshh04CGEFAIN/ae0Uy5QIvGeEcOF3s9aDuMJ6oiiD1m/Pw9
         TdCB4ngQVnTmBSmwlUFxw57SermbSSJer8fYXwyO4ys4hJhQXKmCDS7APJsQ0aIVmLhn
         GRfMqma4mHYoKznAEsmJ63fAAKcl2n2LoO6PpkNFaz+z3hbVPm73Tww31XLgp3KHwBOp
         3Cdv0Z0K9Gy473USJnfWvNb5OH9p3mPU+PKwCtJ+UeCOlmn7AsJ8vSQI7uCHoT4ZEy3c
         Z2ayxCXXoFTcX+MwT5xuk2QG72HZKwHZKBAUYELPmNeYa0YYsijNAMzFpdUimL278IM2
         z+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795867087; x=1796471887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GW+E3bPc2TThHWvpV/0v4yXlrciAMENWcJNOY9IP/SA=;
        b=rJtLvuJdB2V9nYrLSS/TSupbw0oC7vVtiYYco6cXzyAVVRTj0DldsN0MrNvzo/EF3T
         4eE/QYX8qY4PDQfQiP8ueNpav3dEXUlH/lFKL/JEND2sUGnfg9qpgmRRoQOlhs2zY94e
         N7Q+NtoCECHuF3MgRauqDb/zTjjpbqysPQsgKo3Jl0IraFIvh9PDGqqnxGgvgwFCNXK1
         RCkzF0XpYqkfIvzASeyjdVcaS8wqrp8Kwz48moF5Gu2BHWh6WCtok3svKCa6hLUOXmOW
         zLB8q62udXEK/NBVoLXN9GOZ7xiq2m3eX1t7RHKIx1XN4wuLNKAbZqvw/CkcJ/QoRt0b
         cSRQ==
X-Forwarded-Encrypted: i=1; AL+hErFF7ysA38BxRsVwwg+LF/PAzcpo1g88LyXth9CyqIBiQ9aGo8yPsEtFy2APDgx5EhAKJvCTwCIaw0m1pe6qVRu6yoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nCXqkYurYaROPTfumBvJjPilcSzaHC5GrCd1ZQrCkOWw4jFkc
	wTtgsn2m6jBkkpY5qRYMT9hMHxEMonny42kMHdr3zMbi7kGIghq3cPvB
X-Gm-Gg: AZFdTZd34JqB/itaLAdn7iqmJEsomUVQLemqUErbE/uKR7A0LgTHJfx2IamJYv4hQWq
	zHqoGwzBkDTSKTV+tpKN6c0cCUPv3uGLV5JWWXX04QVpT2FXzsZRhIKq8Fx9UGhyrV7IPswrF9s
	9jw9/cWtpF42SvVICaalQ6pnGD3imotbarG9a3iHLh5O4A5HoZ1aabSE2bJ6SocpMEwwObLrJs2
	5I1oc9PV+aWTPvmKQKXFquIxoFBdLgnyZ0LC+H22Q6klNNXG1cKguou+zhUfFKjCFIuKAOtD4rs
	gX7Fy6IzvRwSi78xhhv9isWCyGDE7NL4ZGUWD9tZF9EX6synL+WzzG8BdrXURRnMhLpM6fonwc+
	WWqoWqhOS8rtUrTrBy+/uluFI0DzaM6xkBF46Q4brkNluKkKVg/Zsqdj4lEN1Wo6nI1XOz68d7T
	0jBpiVH64/sFet6keL1hWE20IMXIu/UMkXby9I/uoyAXbpS7tCRI3Kz8dtpr8sJXyjZgADoZQe0
	PR9IseUaWZO7bcxwISuvPH9MLDiTbFk3LhQPuU0Kj/2u+h7btfvDhTlV5Q9svwNy7t5aCkWF1b5
	A5FiAZAJUYlL8hqB/Y1+a3MuW7Ve7yTJjkpeLaavZbbpknhpeObderRn8YJNIsJ9hoykqeeBjUT
	wFGz69Yl3W0KhJuvt+cHcMERL2e/yEm4JKYQBvZ1tfMmCSyUyDHG1JVz3ar22h8Muv/j12bXbYF
	uIC0PK7Yq0G3F3h0y2384oHqL2le0skuhorNC0CvkieSQ+owFTSmhHgsMpDT7hmDl8G+C679fun
	EwTgoUu+Kmyi0H6Sw==
X-Received: by 2002:a05:600c:4f42:b0:4bb:5c5c:8130 with SMTP id 5b1f17b1804b1-4bb8881c726mr704270615e9.5.1795867086690;
        Sat, 28 Nov 2026 03:58:06 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-510b-18d1-bc36-7cc9.rev.sfr.net. [2a02:8434:fda5:4201:510b:18d1:bc36:7cc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm832768435e9.14.2026.11.28.03.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:58:06 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tools/bootconfig: Fix tracing settings export
Date: Sat, 28 Nov 2026 12:57:55 +0100
Message-ID: <cover.1795867077.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Thanks for reviewing the earlier bootconfig fixes. I found two more
issues in ftrace2bconf.sh.

The first drops an event's enable setting when a histogram depends on
another event and has to be retried. I reproduced this in a private
tracefs instance on my Ubuntu machine (7.0.0-44-generic). The fixed
export retained the setting and replay enabled the event again.

The second stops export on kernels built without the function graph
tracer. I reproduced the missing files with a fixture and checked the
tracer-enabled case on the same Ubuntu machine.

The series is based on bootconfig/fixes.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (2):
  tools/bootconfig: Preserve event enable state when retrying histograms
  tools/bootconfig: Export tracing state without the function graph
    tracer

 tools/bootconfig/scripts/ftrace2bconf.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)


base-commit: 56bb11fe6aacc7666938e8e6765b44aa0cf1fcdd
-- 
2.53.0

