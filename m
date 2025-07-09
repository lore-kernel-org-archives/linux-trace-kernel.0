Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9FA935;
	Wed,  9 Jul 2025 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030137; cv=none; b=ISWSUE6MYk9Pq/OcR+6knuFj/mqCbfR+guiruaqj9YOMuZnJN7q3ZnrpRevv/mDw/Z4oNtnzaqJ7h4X+N+vodkVpeA6pVvb/A5MzVjruPzNeelSLYFsy6sSQFeA99bgsrzNe72ZEIYe3KjkQ1pPk7H0f97UB55zmYpwPZb80oAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030137; c=relaxed/simple;
	bh=1TxgMYE9++GnFVSzAjKqyUDUv01Zd/sioU0KNv6N91I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSxvE7cnJ6LR6HVLPla/4bG6lPdSTFF9YLmP7eLedpU6ePl8LMd5FBopodez0uw7SVa5orhuYJvdX9QOgIQcobSXvD4yu/MbZxTa35t5BvojjDcoRPgUiFazk9x11HQIuX8By/7kaZrUc6ai7VcEebVpvG2+LO/zgHL5oMdzhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyGsnWJm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyGsnWJm"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad3400ea3so52471486d6.0;
        Tue, 08 Jul 2025 20:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752030134; x=1752634934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TxgMYE9++GnFVSzAjKqyUDUv01Zd/sioU0KNv6N91I=;
        b=FyGsnWJmheQRPdZ0YmUg9EzOXvIZAv1DMzW57F22FA9MVTHCxLZOkC0XPhsdQWDT4p
         A53oJYXohzVVx253XVlsUj+MZo5Qvms2wzN99TTad6UJZhpqCKbuW+/LqJygNUy77PO6
         YmhwAye/+QthbPBoXm6/0m7BGfpa/4hAVvgriFdtQk+qtkszBcdGPBVqU2+hGF/bCjP8
         rpWL/VBF55qv+//ij5r9w3z+8FiJJjuIxj2F5MZt9k4+joQlZoaXevb9vlQK4+KUxn4d
         gb1ombCp45N3+ImMQGQyp0GCP9w6TzSioERNAABcUz+fMZmFKfmPTezkzTfY1VHfRrmc
         5zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752030134; x=1752634934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TxgMYE9++GnFVSzAjKqyUDUv01Zd/sioU0KNv6N91I=;
        b=omYZZwIC7OekL4WI4hyZ5tAnroeI9oyywD0wTZT6eIOyX8bd1fws80Fhc+NFIFdLTI
         WqjEFNHKkHEeB+c+D2778DqUXvDPX189xDs0WRklh3PdpXQTpdU267Qef4CF5WRHWZLk
         sj9JkN+ZkokVR+XH+vY5SP79c4yMD0ixXnhm9HJ7NTIz4oDGysA4aOOHRSPpMkqSswHY
         l4l/ewrf/S93Z7lKqdV5lYirbXThAbsMtfRA8JaRXMcDd2Y+fV5yt5anphFD9vj0+HPX
         garKNumOoYQf7yT9kTAu2wYrIm3IhmaAZxsALXP7iN6ScA/8zWx+eC4ftFWNCmHqWDVr
         /usQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkZOYnOsqVQ+sI97tkx6PDPFsQZvl7/Xe1csqkzTSoDui/W+7CfANobT8vKWj9U/jJocxyDqn0WDxGTy+7a0wDVt5A@vger.kernel.org, AJvYcCXgU6kP9HWi50LpZWYCH2U0T93QaaAVn840eDVvTGPZUvLGjDo+VhSnyljbuGSdea42GULFczJSku39tlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0zvVSGhqvRgGlOV5Hlz9eNi99vq3WKFVJq9G7LKqY1lJWXpe
	m8d6/ifClWp7X6+DaxyU1MGxkq8GdOoXBWL8hNb0vV/RNnfyVOUJUbs2
X-Gm-Gg: ASbGncsMiu5tYu3YGk8h3Aepin2BntwrjZ2Eq0ndPfCKqcUnvAlz7zFw85m99V8zwcD
	kbqSdTgQxdQSui4n8S1iBZXyz9nko5F3sSydH5gxLQcyr4rOmVEFIga+9+7+fkLYXDvCFPZCmeo
	LtXZMeWBOd3NTSjMTJMQYKbnZqTjAEX8fVnCOfVRn/NDjuz4ut6U55yXlSZjdxFyob9vSEjZKxG
	aRLvwPWcdPEcWcMXBNjObhc6k4FmtINH2OLjN5B5nMBYBE/wALfBHZS1Sm1bdj2BcwU0ijulzvh
	rDwyDVwZQoTUrdiOgyDfqEX20T1hg8OE3M68LJfdIs6R1vXqJTNdSxwmgXQEOaovOecPkrj7
X-Google-Smtp-Source: AGHT+IEMskgkktm/W5i7zY7vOnFEXI8EB3Uo2kSxb0cJyri6/9nwvM/FG7TvB1INkm0xZvjjwSbdzg==
X-Received: by 2002:ad4:5cac:0:b0:702:c4d8:ec02 with SMTP id 6a1803df08f44-7048b93f4f4mr12101976d6.40.1752030134206;
        Tue, 08 Jul 2025 20:02:14 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5a902sm85216716d6.83.2025.07.08.20.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 20:02:13 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v2] tools: bootconfig: Regex enclosed with quotes to make syntax highlight proper
Date: Wed,  9 Jul 2025 08:27:59 +0530
Message-ID: <20250709030141.27483-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested, changed the square brackets escaping to quote the whole Regex
class.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes to V2 from V1:
 Surround the Regex class with single quotations.

 tools/bootconfig/test-bootconfig.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2c484c243f5..32401bf61340 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -167,8 +167,8 @@ echo > $INITRD

 xpass $BOOTCONF -a $TEMPCONF $INITRD
 $BOOTCONF $INITRD > $OUTFILE
-xfail grep -q val[[:space:]] $OUTFILE
-xpass grep -q val2[[:space:]] $OUTFILE
+xfail grep -q 'val[[:space:]]' $OUTFILE
+xpass grep -q 'val2[[:space:]]' $OUTFILE

 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
--
2.49.1

