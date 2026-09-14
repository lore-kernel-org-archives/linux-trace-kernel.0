Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABB361975
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357525; cv=none; b=kfjqdoap1qEvvDtoCuoKuNB8E5WPKN7AYtTX4mPhsuSfP5oE3rjewzzXIa6ZFCDDgN5/Pu/HOgh7NVy4Xb+QODTeXOkfmxpxT63HJesGlqdmBCQ5MietM8dW7smmuS1ua6qQmur9A8YwT47dQLzAk0ObWFLZxgLaccNvnrN0SeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357525; c=relaxed/simple;
	bh=kLQB8+tIzL2zH1e9g3qNWfJ3MutMe/rWb/PEeNpXolU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdluVWQYbgIjp3j2Lyuh10ACOVCo1qEJiOLHWhSVcUMobbpeH4MzMYt+8QiZFvg+fILze5mvEu5+PlxNr4gbe2Ms24m8nwuQHVHztKoXGnlTu9w8XMxmXeaOHpHPTO90YtLo7omDyaZ01hyCK3eC5qb+hOrZKXMpKbqBLz8Z110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlu/rniL; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlu/rniL"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1134610a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789357524; x=1789962324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLQB8+tIzL2zH1e9g3qNWfJ3MutMe/rWb/PEeNpXolU=;
        b=Hlu/rniLg9kmzKhwHQroiJdc6ZqJ18biYifheskyvHh2AmYxkwWFlPbz3X2Q1M8WxB
         aSK4iOWFWTA9UIE6ALfj+KZhR34EizYDpICJQxhAhXD2BDSg4QQV0gDit6qoa4Mc9Fwu
         Y6TaDlkNqdJn+QatQ2wIFKZji3joz+hrcT5HX8DdlEqxZuwZT09YyX7eHSRflT8nGms3
         LHk9Tl384GgmR4GJrlrzzH0OCK1ASCWISXfnYQbZTw0dXZQrnhv0oTuHUV4YIRUJ2Jlo
         Ntt2rM9OGlfMCa2EXUBbI2lBHyGAj6rxH8FoLkHzSyhWTtxVCTdOA4gz69XJpfmY25aB
         r2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357524; x=1789962324;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLQB8+tIzL2zH1e9g3qNWfJ3MutMe/rWb/PEeNpXolU=;
        b=h6+rkz2K9vKVI8ULkrhc/bvnqapEIFVZ0xp0WkQc1RvJxXscUJGO/6TZHK2YjoLyPf
         gd+f8LPX5dyTvN0jA3hiUoCVS/S5GICi5+BdEoh2aBNAi9IsYIu7FOWQN7B1vHK1HBZH
         r/zmA7/vnqtMBJV9aaY2ntOrw1N3LubPVdd1aTOhQgs1PSeaZCeaTxBRqFoiNhhf8bcY
         WY5S9rflBBF5gyAe5eB+kdzEVnMzHyFtPYi2fC7/3MCNsJGhrrfxFkPlgoTdQ65EShzO
         Oj5gVnr+Nx5RKKR50wT46yQ6YLsyFoj6EqxfokAQjIkOzRYUgOZEHpUi22sZXZS9L0wh
         /xkw==
X-Forwarded-Encrypted: i=1; AKwUvBxjrUNQPozZz7vBD+OpdXCy1wAKq+BsADL5NoC7KmhpumK+USHdXkl1GYAh0O/ivR481Y2TUlBPparze7t2dgYsVYA=@vger.kernel.org
X-Gm-Message-State: AFuF++le5ANZyb4dMOhAW8icx2evUbzjE/F8rKE3npVthJNNP5hSigZ2
	hVnHLI3n7CrAbfNPxcn4QpJvy8o2EMPROvzkymKNI0eJhXGTusMs5FY=
X-Gm-Gg: AYBFou1ak0se1upEvSjrSz27TSroSkZvLnJjS78r8Kdq2fmnS5IYjEzQRriNbXZ7/6y
	AQPueFNwnnisr6ZduY9+FUG87I6+hzyeeidDvf7xWG0aBjwgiVJmAEq+2n5JXd7rRCZNw4IODDP
	NCM8Lj5VFqkkBEx+DJPFAHF/zcFU9PVz01qoNs5j+RII0ZXfrzCv7nv/bhcg7nPANZaYJ6MDBLG
	xY/IddUFXqetChTxEKicXlILM7fG2vVH2mheCsjVS22vmRJZlmRGelMZ8bkfsrnG+xpjrd5IH8V
	JyfEX4WYz6vh0yWp1Y8g+qQB8/3s+8Hj2YpWgPXEIcEyDsqBodPnFio5T3jNnfFjHDqmNwSCcTX
	45QrRNGEjNZdq9QJnE5+5wRxadKW9pQvXUTqrJIqtnriBPa8uhQfUfqllYEJu6Ry279oS/4dEcu
	qh8IGy29LBs9YWWiJU81Nv06SayHOXB3fTUvipwQli4M40TxzK7GTLenIzxYdSgmeBzYKW3HqdM
	oXON31UftpZ1lWYhegpeHLJS3oZ
X-Received: by 2002:a05:6a20:d70f:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3db4039d992mr1502008637.4.1789357523650;
        Sun, 13 Sep 2026 20:45:23 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6596265sm4130339a12.27.2026.09.13.20.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:45:23 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Don't log an error for the speculative field variable lookup
Date: Mon, 14 Sep 2026 12:45:16 +0900
Message-ID: <20260914034516.946387-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913204554.91A9F1F000FF@smtp.kernel.org>
References: <20260913203156.941433-1-donggeunyoo.kernel@gmail.com> <20260913204554.91A9F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 20:45:54 +0000, Sashiko AI review wrote:
> This isn't a bug introduced by this patch, but while reviewing
> trace_events_hist.c, I noticed a potential memory leak of var_ref
> hist_field objects when a variable is referenced 3 or more times.

Already fixed in mainline, by 4bddcb346a6c ("tracing: Free histogram var
refs regardless of how often they are referenced"). It removed both halves
of this: the get_hist_field(ref_field) in create_var_ref(), and the
refcount test in __destroy_hist_field() that the quoted code relies on.
At 22098763a10d, __destroy_hist_field() has no refcount left at all.

That commit merged the same day as this review, so the baseline predates
it.
