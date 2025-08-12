Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92362E8895;
	Tue, 12 Aug 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019409; cv=none; b=lHeS7DnvXYG7cp1kipTZTghLoIrP7xSKOMlvS+mquicJZ+gsmlGQiyLzDmXLTEZPfM++BswbM3Y1j6vKNtfI2wn6xGRZFGQ0e9+fdRQ/k5oTxukchW5mxg9gyXLmsIdIBlmiEZB+BU+mFNgFAVYTcYhtrLbTjBO2dNk4XBG8Igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019409; c=relaxed/simple;
	bh=VTKiW/arTSFgxUTGvJKEwKbN5NnUiXVTNCU960pet6Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNOzqU/scdavIzENyNws8xtdSgwHCYv2c41N60dPjl+9sMt4n7CQySlCgWQ1bDojgPKa7rgxjh3P6KEGVpKLfTn95SLfuGg/GK9qSN6TgqOOat7zDK2tdddh2JxGpG0LwpInV2KhvUhjJyXvT9hhzsWoQutikSL+s21T8qM8GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHgwbk6g; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHgwbk6g"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e83d6633f2so318641685a.1;
        Tue, 12 Aug 2025 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755019407; x=1755624207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MEv/35TdFko7V8jKEvPmOrK0mNNoGmEroSq4RQ6znw=;
        b=iHgwbk6gTR5ojEi77ilR/m5QsLDzus2sspf2GYptoJ+1EaJOmLWcSTZxOtjEBESFET
         /8K8duDJx6h3s7G9N/KanXs+5VxNG6b52UzGX0qUNBm48BL5qiinXxVWKK6DQGSJCXur
         mvCMIeLNHSYNw/iBOF8Os5lfPksgUk5SHZHi3GeRanRopjaar6u1EAgrbcelymRRqi/h
         zpouCCxmqNcW3usUlOd9rBi2B2hzvRxllv0kdsSqO7j32cjag7hWaaPkP+4yLFCLorbb
         X7C4+0YESxWN4pS+hoo8Yxhr58Y2qiu82QU/sk9ZZak8d4rzOplKuCqjE+RshdLABXWG
         T1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019407; x=1755624207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MEv/35TdFko7V8jKEvPmOrK0mNNoGmEroSq4RQ6znw=;
        b=UXVcGEJf/ZZ3zNM4WdXrH7Z4d0yk+IJWQFNHgy4A03Wfd3HTobBxhPMhBYyP3MeqIY
         U4J0hnKFqd9+R+9kBirgKxtUmqs4aJwOzFj99WR+cGc7Sy4q9OelOLOR8RTMOJ4jyvat
         UASZO3kGJxsN5/2sS26ZyWd6ZdhZn5+gBoaWm3OlIvvRBVDV5dwtfML+OHJ0E8cX34x8
         AGUm2HwSsauA+0BxFCuC23RDm0uOXKeT5XAh0IrBHqxXO6NWccKDrKSZ7VJlfVF5N84A
         51lvOMbEi9y0RZErmNkT9CMFz5eUs3kXEEKbbmJ2HBatarnljMuivnMYlIScznB/GBc1
         +usA==
X-Forwarded-Encrypted: i=1; AJvYcCWWEHSgdl2IWGtKbPcM24vVBETIJF1s0aU5OawFIPY6B/MwlexJpY8fHBZpR4aWpL1iZ9Hm7HDDGOAqmMum4sDxqtQF@vger.kernel.org, AJvYcCX+8OGg1i0CvOv1JBzaBegeg1f/hpJJGRdX3oWdrxU/MNXzqc+XLnGyG2wKEt6Z2brrXC0LeMbSuRE=@vger.kernel.org, AJvYcCXNpcrH9c2XqJWjiL9h2ewZPh1hz8AyCBvkKVOIeh3yfCa1knQJXh94drhAU76ZUKdIZh0Cd5f5wsIzwoup@vger.kernel.org
X-Gm-Message-State: AOJu0YwNilpPjxZ7zKdRvDOe4r0fl7RRxRSgwB2fVP4j+mbLOZFXOJox
	KUC9caKjKJUh9uzNM9Y6nrmJ+KIvvPDnjvjTDnZi8kAdYIHy8p3loFGT
X-Gm-Gg: ASbGncslwp3S8wTLKd/8NeXZ8+fWzRQevH8EZ0SLa1PlYn2LPriYVt62KBvV7pfJHSZ
	0Y2FqF++dBu31p9ac/m4TtFIaNb3psIVw5ziAg9ZuZgdpwDr2Be6aLwDmFMm/7sII4Kek4uvkJN
	9c+05gygWpV0YpIMSR42khPqMn8R+pBR1g4kXOelCBuSBu1t4xJs0zlBEVeQqukNMUdQMJ88Sa8
	06xs6W6qeRSAjmgqrqpBAsP+3NZJG6/5pp9JTdgTG9WpdK1d4w6I8R1PNW7x7VvxRqaAPN7kusa
	uTbAOxZHZqEzpKoShcodWP7sh2j3AUzyvga/1dh/1Z0P+4Ebge+b/ixEI7GwjAYPdVHd1fk56TN
	RwwRyJu8LnEAIN09WrvQO8RM1uRMQfbB4fLUSQUcf9FVgNDOB2RIhOB9NyrI=
X-Google-Smtp-Source: AGHT+IG9DGtRf9eW7lHgF7ZCSZIm3F4i6WgkIKUulVaxDcfzOzfY48TifK/0jn08i+UfO1hLD2d2cA==
X-Received: by 2002:a05:620a:7187:b0:7e3:3417:8c80 with SMTP id af79cd13be357-7e864593f2dmr63534785a.31.1755019406487;
        Tue, 12 Aug 2025 10:23:26 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83075ffa6sm780236485a.4.2025.08.12.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:23:26 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:23:24 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org, corbet@lwn.net, tglozar@redhat.com, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rtla: fix cgroup and trace options parsing
Message-ID: <cxc4vnifqfnizy6xx3m7rwyz442fur7stbfqas3qxat2opq5sv@zt2eerzhnwr4>
References: <cover.1755014784.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755014784.git.ipravdin.official@gmail.com>

On Tue, Aug 12, 2025 at 12:27:29PM -0400, Ivan Pravdin wrote:
> This series fixes 3 issue in rtla timerlat and osnoise parsing.
> 
> 1. Fix buffer overflow when using --on-threshold option. Currently
>    passing `--on-threshold trace` causes rtla timerlat to segfault.
>    First patch addresses this issue.
> 
> 2. Make -C/--cgroup option more user-friendly. Currently rtla timerlat
>    and osnoise parses does not allow to specify tracer's threads cgroup
>    name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this by
>    allowing users to specify cgroup in the aforementioned manner.
> 
> 3. When specifying `-t/--trace` before `-a/--auto`, trace filename is
>    override to default <osnoise|timerlat>_trace.txt. For example, when
>    running rtla as 
>     
>        `rtla timerlat top -t custom_file.txt -a 100`
> 
>    when the threshold is reached, timerlat_trace.txt file is created
>    instead of specified custom_file.txt. Third patch addresses this issue.
> 
> Ivan Pravdin (3):
>   rtla: fix buffer overflow in actions_parse
>   rtla: fix -C/--cgroup interface
>   rtla: fix -a overriding -t argument
> 
>  Documentation/tools/rtla/common_options.rst |  2 +-
>  tools/tracing/rtla/src/actions.c            |  2 +-
>  tools/tracing/rtla/src/osnoise_hist.c       | 24 ++++++++------
>  tools/tracing/rtla/src/osnoise_top.c        | 24 ++++++++------
>  tools/tracing/rtla/src/timerlat_hist.c      | 24 ++++++++------
>  tools/tracing/rtla/src/timerlat_top.c       | 36 +++++++++------------
>  6 files changed, 62 insertions(+), 50 deletions(-)
> 
> -- 
> 2.48.1
>

Please disregard this and see v2 [1]

[1] https://lore.kernel.org/all/cover.1755018581.git.ipravdin.official@gmail.com/T/#t

	Ivan Pravdin
