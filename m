Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2852D77E9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468167; cv=none; b=cIKsqAX8nhREqDYV+PvyPe333P9r1YQ4GA5Fe6b5sYy7Wch7S0LEOm4jXJd5+Z0FMQWtEt15J2QtQVnOHkBO5zBMVPB+YsvJKO6tSRDWjiCmpmCuyuAviFkXzYhCyPA12IfOiKTkFpoy5G79m2rAYwjBW5u213/WMjykoGHgANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468167; c=relaxed/simple;
	bh=56je8req0e271ew71T6Pq7dZaR5D/MBLco++BrFimxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pS5K+MRKXveF6dRLxZcAGBcNNXHbjHwyGfP4BeWeuv6w9UdyCRHYxRdwqDqpsFXPEvLTcDkeFVQliqzQxISnjwuRzwue/ZfmF7W2CxwhWExtqtAUfO0JeeMRH7uBAQwR73vSEoNvOfoHeF298pUE8siFVpnjWuoOc0QeEtklfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EfFBhsFK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EfFBhsFK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cbae8f69cbso486222385a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772468164; x=1773072964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu2MTxDa0jtmtquCAq9ktXk9oagiIK2smarBH53MS08=;
        b=EfFBhsFKIpiJd6QY2KmsyrJk0BP+NszFwEkOye9F7UEhJabXwFZCmaoELmZJwzTKoF
         IQZ3j7GwlExcgHvRyObeQdhnC+li3pY8MFaUjfXdIxhXseyx4XoMzkOdQDs+e5NeGjTw
         b5qjCx218shDMLK2vEsrVZshXGacxmlof73gBGq8/l+HjjhZkIB5Ys0Rfb5mEM/1wiuu
         vl/GpEzMsaOwZXS987WRUspJtw9s1ZJ6kME2xDAm03amMxREln8zd6XyM+ma0AUMP58k
         c56fY+f1lXqN+gKa2H7Guvurb+F3swSPJyVwXZOGuid0bK/dnzB/4firjqCroU3qdFuu
         a3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468164; x=1773072964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qu2MTxDa0jtmtquCAq9ktXk9oagiIK2smarBH53MS08=;
        b=kWqo7R9+WgDG0W6Yk0ytY1DXYZ4wPV4XD1Vn5QM3S9AflX0TaxcTojAd8L3G+l6bT2
         xmE8Vbd7LV7vOA2kKQXU/9x8805Szi8eIkTZF/jRKoiTw0w+WLAU/PQg3zjlGkpSFqBm
         xEuDzENYmxOFAcEtKelosFp1loRkJPNaC69grb7szXG+OrrEdJgFgkxtf7aSeaYPrbcv
         /NLNfLJhe8txtb5G4opk4+7JP1UUDD+jMqFJogZr3ecH7CseqSVGKjpX9gJcZ8pz0EdV
         zqTqZJM19/hC0/idxb37qs/qn4LG31Pn01zOtvI5SbF9ozjPt1XaFq0jd6bRTPnFhWLP
         FBMA==
X-Forwarded-Encrypted: i=1; AJvYcCVYAAW2YTNdMEqqWsjYwkpqX2lDG2Exqoe2+toCQnYqH1r9xAej/sqJ3ozeZoJeTnR4dnYFeoOfJOKmqUWEGS0CX9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCRsf2+qn05Heg5Dv3FgmiWgxcRuU+22Mp9YXZxl0dKH2zv+b
	4ctWK6v0/ALgF38zcAr87XErWY1cBF1htFa/5aMuswcpttIBSxhYh9Ofq2Dh3+PB8jg=
X-Gm-Gg: ATEYQzzcI7BOs7TF6s9U3aVYdDtNlqYLHloVppZeFhxTT63rgf7M80c4L4OqG+IcwiQ
	Wheumz56vQGBucJ5DwnFtIs7dOZsLP800x0/ZfSE9MlxCQ0GqEIJTZkYjAgcXW9oE8Gn1QFz6mw
	yTjKTSZjKSvsHcc23MQDFRcfUHtNW69bUZmMQxLtcUAy+Sw6t17WFsul1+qxXt3ILGTeZnLcqpw
	lQDwNXP86dUy7JktKlHcj0Cd81Az1RoBwAVCfKHeOfDuZCxUpj5DY4p6BOonm7ZltHlt5RajOOv
	j4mQ30JSTM3ZIAvKiGlCNrJufCff5JmuNpzho5hB26nYiLz5nBNyoBw3CFVjXDWLdizYTTQ4dEI
	fhLEK5w9f4toR0ftdwJ5u6pmIAYiIsGdQE8QjiZKnN+loynGcXPyhWlP5/2e2YUR2hpb1NfM5jN
	/vHABfR/nANMD0HBrHl1cKYkbpd6wZKh3/tbkkTIT9wylhhaXsFsTQrPg6d/UBZOoCUFZtbJg5m
	U4=
X-Received: by 2002:a05:620a:372a:b0:8cb:3f50:80e0 with SMTP id af79cd13be357-8cbbf408e60mr1751526385a.44.1772468163596;
        Mon, 02 Mar 2026 08:16:03 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7374600sm110926676d6.29.2026.03.02.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:16:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, Chaitanya Kulkarni <kch@nvidia.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260302002207.12165-1-kch@nvidia.com>
References: <20260302002207.12165-1-kch@nvidia.com>
Subject: Re: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible
 context
Message-Id: <177246816201.87527.14880550063746511448.b4-ty@kernel.dk>
Date: Mon, 02 Mar 2026 09:16:02 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 01 Mar 2026 16:22:07 -0800, Chaitanya Kulkarni wrote:
> tracing_record_cmdline() internally uses __this_cpu_read() and
> __this_cpu_write() on the per-CPU variable trace_cmdline_save, and
> trace_save_cmdline() explicitly asserts preemption is disabled via
> lockdep_assert_preemption_disabled(). These operations are only safe
> when preemption is off, as they were designed to be called from the
> scheduler context (probe_wakeup_sched_switch() / probe_wakeup()).
> 
> [...]

Applied, thanks!

[1/1] blktrace: fix __this_cpu_read/write in preemptible context
      commit: da46b5dfef48658d03347cda21532bcdbb521e67

Best regards,
-- 
Jens Axboe



