Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3333B966
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331502; cv=none; b=lW1NMakmR855evk8pLfNXHwcGOePRp81vQmk+rE1XcDVfCCdgFwRn1fibSZ1cCOZoxj3/KHK61GyMeV6V4MhtgTpzopj5Z8d2JsaTmYSM/7PII8InJCqb/77DwlFPMZAfUJzqIhI7mIq3xbvJyJPvbFLBSywk/AaVKeuPYXGxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331502; c=relaxed/simple;
	bh=TCDyOJseK6qPBPCx1hp8gZvbnaru+qTNFkWXDDYtmTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzQJwRA5gWld3JsOcEDL9P0LEkzGFLvGEc5c1anOKSS71cLlaiEQhMP49MjpgBN+WfYv40ebnDSpXYb2MkgtzJptAiumk39uO3nFiF+N83MLMu9gXZMwulEVIkn5Aze9ai+TPgse88spXTpfAdza8piX1j1KM4fBSbKSrROooAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/dJ0OMY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/dJ0OMY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1104007a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331500; x=1789936300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhR7p+wss/jt6zjE9pDS80Sv1ZxId2hdmHkP0DmuGW4=;
        b=F/dJ0OMYCv/BbXBbfgVtRuW1ei2HjYvfeE7x/S34wTEkXQQ50aC3qr8a37jZynAIPr
         5zRbvMyuyVbeZqDEsPHjlSKKhbexhz/F+l5ifP+zmRQ2Nn1xqj/POIf+2eX/D/3EB3Jh
         AhEUZLFlg8aad+b4Z5Gti7DEwJOpQp4ImOvcWv04Tnxw84qvCnP0aILHsAuoNj/lGelG
         3I4G2sn9eMK3dWJAy/wd01wFXWACdOOpGebNyPgOte8tpw7wigIa094sdOKgAfGuie47
         6aSqd1CAeiY3W2my5XKYvRw6lp+XQLFaZ4aXMkP8Kqhf5nYDStXsaXd9kkDzQQeiUUN9
         RN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331500; x=1789936300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhR7p+wss/jt6zjE9pDS80Sv1ZxId2hdmHkP0DmuGW4=;
        b=KeJTHbON216EMH7KvuH4X9ViqroVGYSObbl2bp45PvHSB50u95UVrSmbrSpGGQ9BpH
         CYMIMLnX51ZUBvMlqKXmEk5o4cUhzAcYu9zDwiJUxQadgPrIa3QHSYwKJDzcdcEM7aJh
         C8oR5nIlMv6S/0ysyVkZoRNBYsv4S7q+3B8qP74VFajQaoSxm7DXRASkmO3mubeWdMTJ
         vNM3E3zr/0MeYt3eJ2EJ5pPew9jxegiJIPqLt7lO5BAJGv53T3MPpGwtQZfdPlQqhBl8
         whdmf4Rhlwgw0ftXIcZEA6BQcLcPvFva6IXGzJXeT9XLRtJfZVu9K/4gR3agiMGMy/j6
         MVfg==
X-Forwarded-Encrypted: i=1; AKwUvByW7GUVPiEf9TtUjrQinqX/1nyY2REeLd5yvnZcQSH3RBdlOxvSZH2ldx7Z0GpHpvwulAh+bOx4X9OxqJ/Kx1ZruHs=@vger.kernel.org
X-Gm-Message-State: AFuF++m8lmUcRl0YiL3CgazHJcajOG0dU2J1IbtvpGKQyEl2GnWxoG4r
	ErPC7eRkQR/7sMQInlaqEbxX56PwQrUxGM5D6Tg+bFqwLws6PwDrV0M=
X-Gm-Gg: AYBFou1GD19KE5Zp3Lj8Jof2QQBDmur3kJp18/AuSQj3+3lPwIX3B6NeJQp6KrOs5+r
	LrioYH6u6+yLYi8E1oW+YnNFevARJap0jRPaUZTBzjoob7xtxt1pWskG7vdJNGhAEyJ1iGK+2ro
	YO61MdbVBFL7SFW42jCwxpl6T+5tSr9ORz1rtjUaeyMj80oOZ9OggmEbVrOSjDsRgI9IFioPREK
	VIsujDDjZM6FHcmG3/Z9eCGEW8jmG41NM1gve9StJszTzFXf7O7HwnSRffgpNcoMm4O1M5ZTmHX
	//wN6RnBt1P2R9XQTeJnZIn4FVkF4XKyE9ZgnFRE2Z1s3GRJNSx6EM4i5vShvdnf9TyKtcwe1jL
	uxQndUpHJpiOMaAdpw2E1keJL9TEEEdzzge30GhMj8vMRHzbYOaIeXDdzs4McbQL1b/Gxtsrm1V
	3Nuf74DQ84beyPaq+awKXxyrfg9AMpyE6onAwRWV/AT831xf+zaCym3GyF/lKnnsKuKlKAh+AEU
	FWBCJZd660Y4flHupcCJNazZw==
X-Received: by 2002:a17:90b:2246:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-39dbc6f8b29mr15621791a91.22.1789331500331;
        Sun, 13 Sep 2026 13:31:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm17530220a91.0.2026.09.13.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:31:39 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: Add the bucket size to expr_field_str()
Date: Mon, 14 Sep 2026 05:31:28 +0900
Message-ID: <20260913203129.941270-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
References: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

expr_field_str() renders a HIST_FIELD_FL_BUCKET field as "pid.buckets",
dropping the count, and parse_field() rejects that spelling.

get_hist_field_flags() returns the bare string "buckets" and keeps the
count in hist_field->buckets. hist_field_print() appends it,
expr_field_str() never did. Nothing reaches it today, since .buckets is
refused on a value and no expression can carry one, but the next patch
renders histogram keys with expr_field_str(), where a .buckets key is
legal.

Append the count, as hist_field_print() does.

Cc: stable@vger.kernel.org
Fixes: de9a48a360b7 ("tracing: Add linear buckets to histogram logic")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..9d7ce01fda36 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1755,6 +1755,9 @@ static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 			seq_buf_printf(s, ".%s", flags_str);
 	}
 
+	if (field->buckets)
+		seq_buf_printf(s, "=%ld", field->buckets);
+
 	return !seq_buf_has_overflowed(s);
 }
 
-- 
2.53.0

