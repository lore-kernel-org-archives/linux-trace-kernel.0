Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889282;
	b=jx7jf0ymkB5Nk5GU1Q8ItyQ8udkUd/8xo7j/6WFx5tpMBtPW2rLvNP6dqT9vTU3ievt+
	 kqciPftnsjH/eymydxSpELncs4vdok8x3/ss1wPdHZGxyzAggNLitP30rwzNyfoR1UnEz
	 VZTDc2iH7eifUFDAPXLhC6+5NO5uze1Q8+/oTsFbUdkfV9CHb54hHtsZqW8YJT8eRDkaJ
	 xiQR2z8sZj0hJxmRD6fNBwBQBENsK0uQvW14+gQQAVq/ECE8HKvHpxQn8REkDy5oqYQv5
	 LDW5Ii+dpv2JnzHnu5AZpFh6IY6MB3W0nd54x2avj+aeM758hr9nGk3BmDkA+DQ1PxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DfLsQ+L49XY146PqWuFFz/wd7R+ne08otmYizj5jKak=;
	b=xPyqxkPLo4xk1+ZTJPSmBrXARCdNATS8L5fqsNaXDR2djPIJEjjFWtk0FKTo9L4AsHEx
	 Ctaxec47tYvlrNPuUFe89U4xeiRmUbUKK6FfZzIuWAPI8TbHwqKdCYelCoc74QKLbPP/v
	 tQ4HmumwXHn0qA82D9js0S8n2ba9KbM/YqAkL+8kXstgQkebSmz+e5m4dIR40l7pvvAgt
	 OuauhqBP+GsJc8hbebDlawuBykMel5bf6jVuciHCP123dDlI3Nud4h9TZBhClyH72k2vu
	 mVWn3tFND7btO4rv0cu8gMyhgJBFXCShYHa84Wre0kndUKdl017yJ3aLroalKd1Yolg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="q/K3d3zF";
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AC5606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 00:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8AC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q/K3d3zF
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53dda625f63so1207300b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 17:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792889281; x=1793494081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfLsQ+L49XY146PqWuFFz/wd7R+ne08otmYizj5jKak=;
        b=q/K3d3zFKiavoHS/XaYG7Ffq4unbWYm9iIUGXmi4aRVAf3pbfOyvKPv3sI6A98BemV
         Yqo3mTGQdO0fIogMzaaYP+uw98wuubOfwCObtP2jTgW9W2sH8uK2wjhkkfHPG4vf7aHe
         grCYd29OEW3o98UbsvooK/QqOzFJpWOhz+2SMYM/bIG50nDJnhkiPNfxa7ala7GBDjlc
         W4iukfoZTKSbUApRJuSSeuRFM8zvtYiXDo0wgciBHFuijVtA1Q+a8Y1dF8x67RkyXT7B
         vZtQsrTMZ5K1nc0NlwUK92qxADOF2X9luaXZRopA4KfPVER4yH+f3yEpSqEGS87LiOX1
         KgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792889281; x=1793494081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfLsQ+L49XY146PqWuFFz/wd7R+ne08otmYizj5jKak=;
        b=rMTAIA+SkkVKK6zMa1wIVXesD3HGq/9mNLsvO1bIy8uA2Hbr8JIK/VEwrShiUetmTn
         B+RCnVCvzdHKiMpif6dYhpj480h/gdygooIusefIjgHzBrqO+9kKny3EGp0qNQo8Von+
         pfMikBtDA9ATybICMxlA8ACOv8jRhVJ12NOg4jqPvxmnfHPtOTTivfJHbfPSWBysa/Kr
         +1Hw64LgnihgaqmHLPlFu7Fcjtowc6eSPaTaU745i2quoP/X3Di4I1JWvyDMXPR5IwUh
         NwJvYByVerFkXI8RaAAYHsjp6hLXX0dS/KbyJKt4CCYGlz7LIvf/KRt61C+HB+PU3kdV
         3RXw==
X-Forwarded-Encrypted: i=1; AKwUvBzBwrdpC1nfiHJIyLGdaMGqmZNo5291BvSJx0aEg9+q2SE/ge+vnf5iwh+pbRWBy/20NtYbvsfaYWOKmGYlOJlOQb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBIvoJ5I0WshOJgMaFVWhWEx+kh+xFOgLQwIJl0Vc2zcoyXu0O
	vk9vpVoLg1rrQlDAPGDg8TXHKHG2JljvFNetGM4at2ss8G0V8Eg3eRYCk7/MGg==
X-Gm-Gg: AYBFou1BePIMvTwVEyUd9V0PR+qUGddKKPExxID5mq9mL3M6u2X2Wmuo8uMg6gVK75+
	48jLRVWIfsl6QBfuub2o8TZu+Z9qGpe2iDa44XHQkt1tOpjG0IKcaoR+XVot+RsFhspJTaw27Og
	GlTo3iDKPvGOz8S0UyWFe/CdFLwF4OrBGI7YGG4oYhcoAYcqSBIuh+G5FEUEq6BMLFInHGCY4Yl
	sKu4FwjPvbtjkVff6Hbg/Mon83puXF/5YK0aXyEV0eXVPVXLo9KNrrVI3+s1JkCokCdAvYfSEP2
	+0392LVyTuz9N3ustsMhRtUiJCPQbGZIaYtT3/2v06FI3r40IOLXQ2c0r2HeY0MOIefHyiLdM2H
	D+flKXvTEvlINepYi5es0ZhgIRJIpHNcXsEPlglomUTabZKhScV5MbQYVb7rpcMjDH68rl0Gr4X
	zYN48/yuN47xfhHjlHpkvH22OMNhnN5lB9iQ+cLAFTQk+7mITV6NbcSwaJ22DDenzGGwj4k6WKT
	0sdOc2ZIfMHDEhIfJi99o4hNpFnfhm0zWYCFFS3WiCTEAE8v9mlYEYkTTgJSsaNMmx87Q==
X-Received: by 2002:a05:6808:14d4:b0:4d6:9335:d535 with SMTP id 5614622812f47-55c0041c568mr1889025b6e.66.1792889280865;
        Sat, 24 Oct 2026 17:48:00 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm2315505b6e.9.2026.10.24.17.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:47:58 -0700 (PDT)
From: Leizhen Zhang <lzsx618@gmail.com>
To: rostedt@goodmis.org
Cc: Leizhen Zhang <lzsx618@gmail.com>,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracepoint-update: bound section names by the section name table
Date: Sat, 24 Oct 2026 19:47:49 -0500
Message-Id: <20261025004749.432830-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019095302.5a4aa377@gandalf.local.home>
References: <20261019095302.5a4aa377@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 19 Oct 2026 09:53:02 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> This is not a fix. This is just passing a corrupt object file into the
> build tooling and showing that it fails.
>
> Show me that this can be triggered by a legitimate object file and then I
> would consider it. Otherwise, you are chasing made up bugs.

I cannot, so I am withdrawing it.

The only way I reached that strcmp() was by writing 0x7ffffff0 into sh_name
myself. I have no case where a compiler, assembler or linker produces an
object whose sh_name points outside the name table, and I could not construct
one from a truncated or interrupted build either -- a short .o fails earlier
and differently. Without that, this is a check against a file that cannot get
there, which is the "made up bug" you are describing.

Please drop it. The same applies to the sorttable patch I sent alongside it
(same shape, same hand-edited reproducer); I am withdrawing that one too and
have said so in the cover-letter thread.

For what it is worth, the one thing in this round that does not depend on a
corrupt file is the undefined shift on e_type, which you were fine with, so I
am sending only that as v2 and nothing else.
