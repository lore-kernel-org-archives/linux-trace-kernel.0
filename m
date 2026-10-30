Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364733;
	b=bIEwKCs3mvs0od5LnIKo2mvpbs309Ctte+jR9Ceo70BFuz7MQKAXFRxdn24A78TaZC3e
	 bNTvDItnMk2kRXyIVL74bl2kru+OnZtyGOngb6kdYbyt5hjoPNvU6bNeAiwgI/WCudNdV
	 ngElVvJxccYDit2eHF5OMN8XhcW8fPlY5/cNc3Rrsilu/Wetut9tb9hmj6QHAsr0iGQnF
	 /mnmWp6Cl8WVLxKAINUDMF/b/2QJwTYGsAq54pv/bDN44OvPJCPpQTxRjdIOaHeHVQLeA
	 hyonnpCmOlzRph5pvbGyZ+xNJrEBEXzOCQmpadtaXpL6wFQmDeeCHkbZm3U605Fm8iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3wEqCnXTJdlE03KrHWY7VarW5N0vNs2ZED7L58Yvpi0=;
	b=wvWs4MyITQtkeqfJhl+W4pkZSlMrRw4EVvqcW4S33b2F6D9Qtj3aY5VrKHPBABWGnbEO
	 04jceFNFlolkTD7s0NjTrSR3duemdoNqFPAFySdwBNsmFe61VWklJ7zlNPv1Jbaja8cPe
	 dZIurEBUYfsxNsle1+yLAjWWzSSbDX5pTl1Om9O3LMXE/1mhTiD/A5kOMMcQTmgWZO7Gv
	 +CfKi8k3nXN91Q/UzLodPe+0swFeJR38x/r+KJU0CsIh9oW8hB51ATm2xeHwPT+Ab+GUx
	 6coW80ApoaptfsiGI3ZxgQjX3abYDXgUIs0W9FwP1E3xrFtYTPnFv0eYZiqsV91MlTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxY32tUv;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9719606A31A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 12:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9719606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxY32tUv
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20edd106so557326f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364731; x=1793969531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wEqCnXTJdlE03KrHWY7VarW5N0vNs2ZED7L58Yvpi0=;
        b=QxY32tUvnWs7viGQJ0XZgaAd80fTZU3QcbZDkWyuOD+bWe3SdyAnFYsQesGkthYgBn
         7SxBn5KJDQgNx1c51eyfCyi9oeSiVbzX/CHPkXAVj/r8aBMZk+Q8P4fcTuGeajX2EHme
         A7D2KaATNPspXRe2ZbWsl21Ir3fQXB3XcpzrDeSAdhhf+mq1+5OO1P/CuRPCk+BG6WPI
         eld1qqwUlsDz7+mb3UPKmnGSs8bEFaot3P/XE3+FZc1TggI8GBCMjeqI5U8adrcZtXNK
         T4vc0E/HFlMqaO/i+SWpucA/TdpZhvrcpCU2gbrfkQsVLnIx11bETVQP29DotxvBG0Ql
         HPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364731; x=1793969531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3wEqCnXTJdlE03KrHWY7VarW5N0vNs2ZED7L58Yvpi0=;
        b=z6zjULdABiDUSph1mAArMtf0Mpziia1toZ0bGGaRWrw5O77c22tnOql2A389ZpOJsT
         EFcOPo3D/aBkihr6PGBfpbBCOqLJP9lahL3DWwhmasMvYxVEJe81yi6ZRpJR/aKelDyI
         H1KNkaD70+625RS4zjZshsmLmLScYz6FzDZnFfVbZJGcEL2i2+pfCaVCqL0Zl+Mq2uxG
         KslK16deuzVbKzT6lItx8RBg9XwtS3B/zDP/e2THMgd9fhNIRj+DNNu+s0mbdhWBAV35
         RH7nTHKGOyxTggDntaW1DffwTqz5WEe0b1iJ31b2J7knHL1snKWXHBLSybQ9Rf5Ewf52
         EhKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoEWs9EWlESCG9p2LL6SYaUEAfMJBhPW1qrixW7eyNnZs+KOIVFabGupXuckB2/FqMnc4lyF1/f8UEMNJ52NkxHao=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOppD5zqYHqd0t5Z3cBUxH7BLYk7uF79VNxepWPuXpKpXOTuem
	sEKDOzdsYykoUAjS7hCwqFiOmkNcIR8M6YVPd+nOsXPjpRJHEjOuLUS8
X-Gm-Gg: AYBFou25bTMfXdc3Bk52mujeZJocjSL+buTJPTigrvbxhTuQLLP8Cf+eqsPKvesU9TD
	LX4OTLPrQTB4TkcuJE4RYorBUIqUPIGFO5sZxssmArSkgbuRAtqwC2hPTHyu0AdFKQdf0pIuTaX
	Hpz0s+SbxB4f9LmO7vHYZxjfvsPkt180qfdRFzix5Az3CGgseDJ+S8RbCg4HbjmMJV/OGp+BhIE
	yuXschL9YFQNBCPMjA3FPtOyAh6h90xR1KAsp7knmiOo3SuMk/H9+30zlJMVik4n68Pugv932as
	O8AvPLbnNjMgR7ai2XGv1gJD5u3cnSPbFTLxg89/t8yA29mM3bw7pPt6bxit0VZZab71i/66KKE
	D0h2D2eFeCEyuO8ZZXL0fBPqdRIwOK7pPJnpbYqbbBqF1GmExwzgaDesPG5/eC7CIG5koSmDfgT
	iEK9gbaVXsPaGNkESQGxZ4a9kbiCT4edcq4gISRuee3HrDh0u/5gaCp08sVV81rjf4aoNGu+OCd
	cdxKfVsICXcWeos4NIrjBdl4jYrQT5895o9VzN7m0Cuh4Ur6bVtBko2w8g9yJG/XPj5vwF4sHjN
	/7Zc5XMWSjLBfvsQUjX5RplykIRaGO831gU2whRKEBS4EEYncLpGjxj66gQBie2vHaiVD+4m1ki
	M7iDzhHSLL8SHXdVArJehw8csL4AbJT4ll2uAqXUQpD9BYs/XqU18jmIlFXZ2y8XzzGgsD0TQzj
	G/Lcxq1RPy8hU9MARjl27i2Tqn9BM8UPX9syZWY2keRbV3QGyZJm6mAEeqQnNvaoYxlhAKd8Y2x
	gbR9fcW
X-Received: by 2002:a5d:64c4:0:b0:48d:facb:5937 with SMTP id ffacd0b85a97d-48e6e2b9ed0mr5326056f8f.7.1793364730865;
        Fri, 30 Oct 2026 05:52:10 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-a479-65ed-4521-39bf.rev.sfr.net. [2a02:8434:fda5:4201:a479:65ed:4521:39bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723cdsm3170047f8f.12.2026.10.30.05.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:52:10 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] tools/bootconfig: Quote event filters in ftrace2bconf.sh
Date: Fri, 30 Oct 2026 13:51:48 +0100
Message-ID: <a60d6ff14ecfc1ea7a20444fd61c5ca47385e163.1793364709.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793364709.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com>
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

ftrace2bconf.sh emits event filters without enclosing bootconfig quotes.
A filter such as prev_comm == "a,b" is therefore parsed as an array,
while a # truncates the value and a semicolon or closing brace can make
the exported configuration invalid.

Quote filters containing bootconfig delimiters so that the complete
expression remains one value. Choose the enclosing quote in the same
way as the bootconfig utility. Leave filters without delimiters as they
are, including expressions that contain both kinds of quote.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested event filters containing a comma, semicolon, # and closing
brace in a temporary tracefs instance on my Ubuntu machine, running
kernel 7.0.0-38-generic, with recording disabled.

The original export split or truncated these filters, or produced a
config that could not be parsed. With the fix, each expression remained
one value and was restored unchanged. A filter containing an ordinary
space worked in both versions.

 tools/bootconfig/scripts/ftrace2bconf.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index b01297217cf3..8c5889d0420c 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -126,6 +126,14 @@ per_event_options() { # event-dir
 	fi
 	val=`cat $evdir/filter`
 	if [ "$val" != "none" ]; then
+		case "$val" in
+		*[',;#}']*)
+			case "$val" in
+			*\"*) val="'$val'";;
+			*) val="\"$val\"";;
+			esac
+			;;
+		esac
 		emit_kv $PREFIX.event.$group.$event.filter = "$val"
 	fi
 }
-- 
2.53.0

