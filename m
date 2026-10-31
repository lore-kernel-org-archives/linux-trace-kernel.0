Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793476354;
	b=36ve3Y39WP5K04a+uV2VarwPeMVBUkVIg3RV+8GkfJECxJzexRuWMStM9m1Y1qwIKzfu
	 1appkzKvRkZW83GPYPpuKnQYXaJAvH10GqdeKVkFVUcnM27FjhJB/LOex9TdMxDdF+Tsb
	 D+uxiVEoFddhtjwoxIvH2KI/+YyoQlNprA5wmXxralHkGVoE6pES9mzICe0dptbklc1Hd
	 CeCgbiNNT2E1B0JsGx6SUYmQEnuRhJ+DknMrWUeplETrADaqj9PXl/VFyuuyw+CQZmISc
	 6sQP/Er+ggFEmE2LQThT4F5QftdWX9YwV/iiKSIQUHjwLTqYdZLONRvIiWjlyzEByow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793476354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ymL5qvPWIyrF5/LXgeDe0TiyyznlTEQO60Qfnl1OooM=;
	b=is3LH2R/d4QdQsZnVtPIipBO2PiB15bWCADmfsSkBdhFrVv+5EhZkrN3bE3ZJT1h/Ovw
	 YyrcounwGe0uR5OgTF7pn8FY40cWC7SlQZrjPQvfpSL20OrixUsElRKFtiDwmT3TFoOEz
	 kLott5vEtWqRWxUqKU2jhn+Wq1Y5Cr642q474JrI7GodAKkLidsY20bKaM65qrOaoKMf1
	 puS2A/vPdtG5giI/zMuxczt22IE9VnwPpyWKyhElVVC+IaSGnW29a1QubgRr3yiJvzXIV
	 5afAvqs5S/zkengZwe54FCdzTnwjYIbnp2IJCK9ctrmo9woHyanSwD549ZhyyHMxa6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="sJ/qWUYe";
	arc=fail smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3524606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3524606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJ/qWUYe
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so1916656a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 12:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793476352; cv=none;
        d=google.com; s=arc-20260327;
        b=RzDYsD/oq0kZk+ltAtr1jta4puXSf3VipdJZajp6sGyldA3jAyjYIHNFqHvoB6AsPU
         Db+R1fFwmo/+NUmLbZmXExf277k/IGvR6zGEdS6LfEYR3/mfXPmNQp2xdopDNlUkxf1D
         qV/Y6BPFtGqSwUN797tSrCBI8xWqSowZ5j/dpOY/KmQSQpwLvtWg4WW8IPacrQ8p25fJ
         UUvbyrsbpKyiKKgLHEh9gfhDKcgKQ0NwDGBZfg8BWRVVkgpPgColgmYlTyMGdQE5inhh
         EkqeVa/0y7P8O/jDtcVAyF1zzKSEPq3aLulO2+R3MpGoepqSIiBG/eh7ufDKiuzJHxmB
         l6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ymL5qvPWIyrF5/LXgeDe0TiyyznlTEQO60Qfnl1OooM=;
        fh=Hr/Hek5iE0qlHfTDcsaQZevuhoQsKK7YzYeOeHByuUo=;
        b=eBK/8awo2qmqghei4AtgQc24PXBmmfgfSMoNbUm4iCYdVFulzapR8lxrbaBKTrlaC9
         aS9Zu8LSWb8zDBDwLBVoNsIDxjg9GQk8wCTSMY1G1ixkpcmLidYQzxiSWKQg6NGX8L4+
         h035se+1ht7004dZbkseFvVTK9gBcxEnYxyVYBx89dP5wtaBqkwxD6ISC1kk3BZE4TZE
         FDQRkc0R0ntwQCLd3KuyWj39QNjA0/8FTRveJXMlFdKHpN+iBhfOoXhniOL9PHXYMb+/
         qC8Kw/XNjQtzDjHM0yCnarmfNpRt293tZKiNd9K8ygp0isKBJxCUZmyWpwtOqSDTk5A0
         MEKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793476352; x=1794081152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ymL5qvPWIyrF5/LXgeDe0TiyyznlTEQO60Qfnl1OooM=;
        b=sJ/qWUYeZK3rLitin7DaQ9yR/pCebouLwaMLZeW0zFLKw3JOTi5tpBBOBhfTiigatX
         aNkDwjzEzA25nxematR9HFA6xoSmHuw96vCPGJUk6ZkK6VDZYcY6UPNzAvwAmEInCkAQ
         /yjyiOxvlwkfygsIpVxverGM1ljusLCQPI2fJBrkpbmAEpByvCxX29uKySihIIXlY1By
         gugiY22kKh3IzGU/m2TyxZT88UvRA6yrv9gXEwOY1bBm2sdmOeH9iWxUJRyRTKN8XkXg
         z0yuTAwJ9XrK7vYBDJMHtBR8hNosaHskp6xxZVhUtQO/lIJR5AEERY8o5PyjlFsok5U3
         kIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793476352; x=1794081152;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ymL5qvPWIyrF5/LXgeDe0TiyyznlTEQO60Qfnl1OooM=;
        b=vY7BUZbibW4qcp9aZ4woi9WQbNgunE/OR+he+SKmEnB8yfC26EJH9BZFFXyfTWkgoM
         OSGlwBbT/PRTi8pEV2E6NbMakQYORRtbxLIKax5OgIcmMwyuTpu0ucL4iYki24uqVHzq
         wLAY0h/cjfWfXLPsHkrVHuH8kkG90tA+IjYbdSODcIcO4Dys0wnkq1uwLVL/w9Zr0msE
         2hcJYfmVY7ErlNdBUxhUbrIktFaItfeNcjHC8ii4LM5hCmar5mipaJBSt3Ltmid7nhYS
         YMzFIyCEOTS+LroUT6zwIUSGkjIYeG46IpY6UpY0HH9qg874KckvdGL4KGS35Cj0uMVK
         q8nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVApk0X+bNwaX1UnTw3XxonTnqpMU7NJqAb7aDVInFgJw8csxCHJ/+f96agv3hhG3wb4j9nsD9BJagRT8Ur2S994Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3Jma5d6mMO/fNQG2oU66lQZiff6hD9Vt1pvp7G89vYuTy+dFi
	4gNz1rdmpCRiXYYnOIgRS498LtxoWqEP8mMMUt3xU9MWzOj+ScKFL6eO1Qo+wH5X1Wsu5BoiK1z
	8VQ2QJn563jlwIFZUqUo37ir6+ON6A4T3ndu40s7bxMeu
X-Gm-Gg: AYBFou32YyX+CBSWeJkvunZxrUsb/1mpw7KatqhTEfMrxAA4u7mhoT+8QixInoVwMJ2
	Wr793PsPyq0R/2D2xM5FrwW+StOPVUIsNhxyIDZYTsKqn3KD/zpS4AAU17fDUq17ZJRzD6E+Gya
	TW2zvRSXRt/uqkzLx38b6k/hvsA50FN/j2w65YTwgMB7G54Jj3i4OqlErewG+qciKvWdpLfyBJ0
	2qhaQ5nIWkUIhnRFY7+yq/aEAPARP68ZQOI5GrpVUkB2t+tfrmJ3a0VUyznI+DNetZdxP9//dS2
	SAurjOG+zmqbWQ/iIU02b851VycH70TIaCneaN77JUl5jENYMsSWzl+a/FdfwaGt3j6zurcKh7D
	4eWli6LmpYsPUM59zSBFhn8rDMSO0xyfhTJMmlCo39iMKoEv9MfIGjOeq6nTvCigOrbEBCQ==
X-Received: by 2002:a17:906:7952:b0:c2e:40a0:7978 with SMTP id
 a640c23a62f3a-c4ca7a54f88mr480913466b.9.1793476352048; Sat, 31 Oct 2026
 12:52:32 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031175213.704021-1-bestswngs@gmail.com>
In-Reply-To: <20261031175213.704021-1-bestswngs@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 1 Nov 2026 03:51:55 +0800
X-Gm-Features: AclHuK_4noahyXUVMwaXTRsGR35d3pI531O4mEpXqwFeyal3vHlzCksnNBM6N8I
Message-ID: <CANgPUi06dtO2xecWUE044CWYAaFbA4au5Lb4XU08-z==YAWX0Q@mail.gmail.com>
Subject: Re: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"

Please ignore and disregard this patch ([PATCH v3] ftrace: Complete
subops teardown on shutdown failure). It was sent by mistake.

I apologize for any inconvenience caused.

Best regards,
Weiming Shi
