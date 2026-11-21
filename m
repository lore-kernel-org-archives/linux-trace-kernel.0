Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260725;
	b=YNcTy+cXYGJ3PneVUOCgaNa83a9qoq9gsvGwMgSIhSTl+qiwag7LKB7KbHMv9Kj1dBVv
	 wUdnEkQJ+Xi8ZQbx3d32AUQznx3GFsA6WZXzg048p7/5NvAZjbGY3yCUZkMZ1BeWUsYtr
	 FTc1pk+/gFtTWFVDbdTjzCVMF8fikgQ5nHn4Sf7nfZXaCNFTbemdmKN1O/de0YugL0Tdn
	 eztRbnwJAKwBlR5pcDbAUdx8fuML2mwdCNZvDvB/wETffYkWEBH2hLAKgxaub8YXkOCiz
	 1TekNpJ3/YwR98oTw4WsIfJwNOcfTeYa9PvpBoOizVMtAgdFjDVGi7QMYcsxkZ2wNOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NGCS/K0a+v9qdamXn5wmb9umGowNWIc4OW6YckyqxpY=;
	b=B/woJ7TGkqVJEXwqPyb9YoRLP+qdBUE4xnHnCDzVYoPXP7n0aFWpghdRwtwNC7C+7U1Q
	 BdX4ro3D+QVD1/YDtuomToYEXRy/awYXbrwn2UcQ1MeJh5SvpKeB/J+XLf1r0b2kAsh92
	 YX0wTs52BwjS0SpydkYjVAk6dDnCgp57RwZs6yvd1sRO7YV2otRpjpq4VxKVdOy7Zy8nh
	 MplgRmoS77oqN20OPr5jfuWC7c54KKGZYGiHeQn60o25257xpDyETWuQkRQH7r0tCVjw5
	 MaEi+zxO6H3wVpJSCgg7rtfJHkxesHQ/bVhwORYT1B+DjtCDk5NgRXN63rPtccaTCnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cG0FZdK6;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37A606A325
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B37A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cG0FZdK6
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f05b465cd1so4242275ad.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260724; x=1795865524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGCS/K0a+v9qdamXn5wmb9umGowNWIc4OW6YckyqxpY=;
        b=cG0FZdK6k/9BZZ/csAcJeoYIIcI9VALnU7XuyUOVDaBd1Jyft/xMXjHhByjGbqzDM0
         Vv0R4PNG53KHR+Uqk3TDv+LlSLD5wVcc7woOTHWw52ODkLVX3vQ3LMFvQ6/DqBJEx35q
         YitFw8LPBtp6x2DdxrEOTUmWeS0xLULSqYJ/SfB7UP5y0uyubwYbJconRMdL8MsWlhNI
         V4WHnlePtuFikE8bD9i7MaIZ88HbPRJpsif6TCrXe+zfDRoKwDBXAHClVTtHcTIurLXV
         01jyk0XXxvHZz4/cEbDjMdeOpv5BcKY84wkVoSvU0DYY2lzJH/nODV8WeTfhVRKkMbXY
         KZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260724; x=1795865524;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGCS/K0a+v9qdamXn5wmb9umGowNWIc4OW6YckyqxpY=;
        b=nhUVFqkDu+NB0mTS3JkbKXd/qPDCkHuQwcM3wblGangs2/3BAwKz98zLKUaxzcpRdt
         UKpYd0X6SyKxu5V9AFaq3qpZ5a0U18bapWC3qXKQDwxExj6ZliMIDEogT+N0V1F9HcjY
         uzDoz5E7r2WY0jAtGpuSfx8suC/Y4J9/9x3zG2QB6E7z7gLpSULvQC0BR3JigGGwo7z2
         QWuoEHLNivf9DYx8abimd/FrBOGUxNAU+pWH8/xRiPI06oYeqYn6ypgfMXN/W4CPO8Lv
         c0hq6JH+JiO0gKw8/SU1GXZV9uZWtFjsgBr3TDRMgdQ96fYLZS1rQNIbtIzOQuKXgmIO
         8CNw==
X-Gm-Message-State: APuU4Z9xl/drirlMOkZMwDLuZNVuub+SaTgHq3QkDTvZh0/WS8NM950P
	ekJmqaQq56ZUsU6K2epbTgkNuNoQ3ndzc8HFfuZLkSeoOtiE0otilSbU
X-Gm-Gg: AZFdTZfdbE94flp5qgwWtifbxpD/jcgbFn944AHh0mtCFu2yljUN4fgtqnvNpTeCN5k
	ErTPIyFTxRrYljZyY9VMYRFfTxIG5HBKGFCskOxoW82gfoe/qRHotoLV0dsfdRnjLHioNkvNoNm
	K766yeJnVVIwYkykPQ//FRAbM+ToW+bIElRqIUddxbPPvOj3P4uyddya9DgnQNBS0f1lHeOe8XW
	k/5YpZlyO7SRnKRX6Wr1Fq5AyiebE+9br867/A/1ZEbCKJ0jKyT+FnQrLRYx7pv+hTW1DGVhFBr
	m9gNsbhCufQTpvgbIVs/CtLIcTEu2v3eb5ViG1gD3AuS44gYWd3ZBotFIukbfnXwc3pZspy0xPx
	bMuT09lohl4q0dHgkhaaEGoM6844WDIcqxw7YV9qZVIo++bl0sazeH5zO1RRPpu7CT2JRGGxcSy
	T/awrPOsW57O7vnmOHlhRbi2LxgJBDwfl97JUCeoTEQAmA/++uLDAqC7owmaTTDQ9E4pAk6dYj9
	kj66D6uKSN0BHmnFxnJ9Fhu2dvHN7A4HJZcBek/498FnUpH1NJefs1SomwJD4No0mkIax1/s+HQ
	OyZHqVc5HFBNBIemtyREN8Rwm5+QxFwwb4nxmRZjzQ==
X-Received: by 2002:a17:902:ce85:b0:2ed:1350:59ff with SMTP id d9443c01a7336-2f03ef594c0mr58057885ad.3.1795260724508;
        Sat, 21 Nov 2026 03:32:04 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f6049dfsm16057885ad.19.2026.11.21.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:32:04 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] verification/rvgen: Validate the monitor type
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <cf05914335850f6835ae79b34d6b4ad891128948.1795252297.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The monitor type is pasted into the generated monitor as RV_MON_<TYPE>.
Nothing checks it, so a typo yields a monitor that cannot build and the
tool still exits 0:

    $ rvgen monitor -c da -s test_da.dot -t bogus_type -n bm
    $ grep RV_MON_TYPE bm/bm.c
    #define RV_MON_TYPE RV_MON_BOGUS_TYPE

include/linux/rv.h defines only RV_MON_GLOBAL, RV_MON_PER_CPU,
RV_MON_PER_TASK and RV_MON_PER_OBJ, so that macro never resolves.

The accepted set is already in Monitor.monitor_types, which the help text
prints.  Pass it to argparse as choices.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/verification/rvgen/__main__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 246b43fa2..6053db5e5 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -38,6 +38,7 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-s', "--spec", dest="spec", required=True,
                                 help="Monitor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True,
+                                choices=list(Monitor.monitor_types.keys()),
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
     container_parser = subparsers.add_parser("container", parents=[parent_parser])
-- 
2.43.0


