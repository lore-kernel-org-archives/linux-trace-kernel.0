Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96133D565D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319573; cv=none; b=H/Yd8y/lNTc3dpmKwyB3xWHqBrLgTt+D4T2hPkTcczNCq3SOOcremZRtBVHI4zxroH6AQ8Ob7yF35j8tdqJcSRu9Klde4YRJCnqhRI6MaCC58zXXa54Pku8d/b0hgs5fG2TGxBpKJRFPJj3bF0XDQtITmDWYi5UirQo7H+x7Gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319573; c=relaxed/simple;
	bh=MOYeFniGvmr8Js5OOvoPZC48pNX78bQyUkfxY9VoolA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtiDPTDphgmcQuz19LLEhyHrBHn/tt5yBYu3gUBjWsCskfEqoSXXu/0e9QtX2v2ziEvudX/i36A7AbFcJ3+EuPEzHS9FWlBdU61uDAWlpbrBINF8E1ytgG5Tvi5Tt/TdsHv7k7Q19q/Czpso+YWtLZfTvaA+ukGSyQzJ1upA8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW7XwqpE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW7XwqpE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3498737a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Jul 2026 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783319558; x=1783924358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhtgfeSaTAhwf5Hoo52yss2OfPumcQhc+FSz/WL2078=;
        b=cW7XwqpEhzyiq4iJnfYlbZ+gyoJxWFNtk2Nju0fIVotX8/9AHAddzoD/BgXZDgh6w9
         qgAQ5Td8UeBnUUPzWqNL3L41WJ5CMSf66oeaFNjr6MH+dCwIFF7aWCmrN/6C1nYz3Ebt
         9bmaH7y3UvQfpVN9jObJrXWX0JwroDrATwFVaUzydsH2lJD2eqEtniO9ftFC2ykkg7ev
         mN/MkqaeEFAdlDUutFJ8FVUQzUvkESQQGJ8SFFfOaG4fsWoq4kXHHXYeFt3GKq3xKyLP
         mjGNxAfAQm0k/LgGzwC/Zf5UIcVgMvxsQMcT6AIVqmbm5jCfoNaHJ2L9/D4Av93v49jA
         V2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783319558; x=1783924358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhtgfeSaTAhwf5Hoo52yss2OfPumcQhc+FSz/WL2078=;
        b=giUaQ4dqR05wLJi/4hiWqcpbWOYS3mTY0S0N5M+UVT4GttrYpoTRi6OijdZACTsWod
         erCaeqSX2ji+W7ykLddRwFi5vSaGusZPMzqJfJ1w+KZ45UtUJ9D8ezXQCGPIt1tmXsnR
         uIrBD1/yPj8VvsTQyG2oXxaoJBq+BfeXuG7hTlymnzXcfRNoHl4y2MQ4OI3JglZ9Nbpt
         ncdqcq7/l0uc1rqQnWI+HEz0bWSkVp9gF0aVZvb77A9R9AiP0jqsSEzoViDxHrqtmW/I
         uc6lVT2jccKORQHP/HIuOjWfsdmHZJUDAZFbF4M957LwBKYnEmO+k/1fSDEmyv03VnGd
         nPlw==
X-Forwarded-Encrypted: i=1; AHgh+RricDBb/qus6EHEO5xDEThjShWVqSh8v1my54H8Gf370zBdQeKKhG6LWS1D5h6eG+eyOFB56XRPt6zVw0UAd/LjCQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6W2uEeND8Qsb1pi6epAQydoN9wbxhDtJngyYA3G037TFcFVld
	j7GAJRgQyFCArkOMzPGn599G6wCtX5lo6KMFbVVUbrh69ipsl46T4/sC
X-Gm-Gg: AfdE7ckYazqo0sl/+M8xqUSEbmrxJ7ti/odZmdYvrrcqdMFnHLK2nUb2o2ANJVSj8rY
	ndBEanrKXwLE4WE6bXj6f4nrmEXKdH1Vw0ryhfr7HaZHilQK9XYz3MNyT+f/To3zfmi2K83sxaz
	MAxVULpGPGm10/sIPis9m7vjUXNJblKYhHHHe0eYlF0HhxRFGhDXHah7pAjXMx0J6IU6pxScDNq
	81hdjHPz53b7orx0tq+HKdU25AHG9NVT5V9PbleLVpYJ5375ra4vI5J68Zidr09Q4SfL2ns9ow5
	mTQYB78KBIAQW86EcVcEpgYVIpIIAoCnOTW3hx/ck8SQz7oNrajt1e/Jg0Nas9p7LX9Td2gTm3c
	d1ZbYSp11jmKy29N3A+mAfQQDpV2yy0rnflQfIuZXWZ3EMK0k94eEMtL9+noEJAYs9xGp7u1Ume
	7qgMoZId1eUOH9KyO/hF6R3EqrSoFuq4d3XXRfv4KaoPL3b7JDqMzTzlpY+RASJ8cL
X-Received: by 2002:a05:6a20:a10d:b0:3bf:6c08:2840 with SMTP id adf61e73a8af0-3c03e4c3063mr10037424637.47.1783319557731;
        Sun, 05 Jul 2026 23:32:37 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:dd7f:bb0f:bf91:128d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e920d7ffasm5406424a12.22.2026.07.05.23.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:32:36 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v4 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Mon,  6 Jul 2026 14:31:54 +0800
Message-Id: <20260706063154.1947674-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616064119.438063-1-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Hi Steven, Masami,

Gentle ping on this v4 series now that the 7.2 merge window has settled.

I'd especially value a quick steer on the two design questions from the
cover letter, since they shape how I respin:

  1. Eager vs lazy allocation of the element pool (~8 MB at the default
     bits=14 when CONFIG_FTRACE_STACKMAP=y, whether or not userspace ever
     enables the option). Is eager allocation acceptable, or should v5
     switch to lazy allocation on the first 'echo 1 > options/stackmap'?

  2. Whether to introduce the stack_map_bin binary interface now, or ship
     the text stack_map interface first and add the binary export once
     trace-cmd / libtraceevent integration is designed.

Happy to respin in either direction. Full series for reference:

  https://lore.kernel.org/all/20260616064119.438063-1-lipengfei28@xiaomi.com/

Thanks,
Pengfei
