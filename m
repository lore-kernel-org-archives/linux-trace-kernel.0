Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jiDqKR32"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768297
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:19:27 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5caa401f151so32529977b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700662766; x=1701267566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUuXue76CXuXMitsPHyW7Zcj/6p9bLqIblRtzrqhwvQ=;
        b=jiDqKR325AsSVTS8DzN/wwQi/NeIYgSKsysg+L7A3hQqDuHs+TNnxofD5L9q4Y0HpS
         8lKCybw3PcFCyw3OuNBNma/cpIzeyTqX7GVSneE1SNOt1wn6Ss1GXdvlIL6V99yBqDBg
         0AxCd1pS4ntqxaY4LdZwjl6tJwpFvmaSpT0qtdFmM6iiXzSsx/TQeTFzAfbsp8dJsdFr
         5HYNxP8d0vaC8qQLCB3BNy9VdbDIpCRpQgeLQhrrOBAKN2eKxgMsSB/56s4R/+HazfTd
         wGUdQ+Y0VuAm8J04T6TaRam6oHG5WlN9IsASAXeRh4rwER9XXIVzcL4S2n4MuN8FbQhA
         gfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662766; x=1701267566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUuXue76CXuXMitsPHyW7Zcj/6p9bLqIblRtzrqhwvQ=;
        b=hClgrqtEMfCjIgLQkXWZu29QcP2/0X/uu8YyCRN7554xSpCh+5zE+dCc+qEuCCUOl7
         t6jkX4qmIrvSGQr7Y1Nd6agorncI1OJv9mSGdS6LBsprkvFoYfdcbXRqsepmmbViGlpt
         9Q7NKITFF7Uq/KUGOGwj6w5WyQesHB5nTxh955nJ4jzpdfZYXsJAm3iThFEARt3ENE/S
         UDCtSJVvmghoNUWZSiJn5UlRdFmxOlw+N96OZ4hGX0rd2QgRqb4YNeO697oJNNHN2K16
         pB1FxDwARM+dIp89H3ikAlnwHiJ7kpd1dCERZvgjzJjV9eL0pFmOMHxrFqEoHmN25VDk
         9mkA==
X-Gm-Message-State: AOJu0YzAUCS125lGyObaCI/WjpGfnUcsuDD8eRYjHUYkv6zMsAEjpZSR
	71ggitDZCSYfeorBTrTPLdxjYg==
X-Google-Smtp-Source: AGHT+IErqs/PN+B9z67h2+4TqPZfdz2AvdCCefan27RDVwGuCmaVTVlK/X6QugZrb3WlD40MFx4ijQ==
X-Received: by 2002:a81:8742:0:b0:5cc:c00:8d73 with SMTP id x63-20020a818742000000b005cc0c008d73mr2293819ywf.45.1700662766313;
        Wed, 22 Nov 2023 06:19:26 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k68-20020a0dc847000000b005a7dd6b7eefsm3704869ywd.66.2023.11.22.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:19:25 -0800 (PST)
Date: Wed, 22 Nov 2023 09:19:25 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] eventfs: Some more minor fixes
Message-ID: <20231122141925.GE1733890@perftesting>
References: <20231121231003.516999942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121231003.516999942@goodmis.org>

On Tue, Nov 21, 2023 at 06:10:03PM -0500, Steven Rostedt wrote:
> Mark Rutland reported some crashes from the latest eventfs updates.
> This fixes most of them.
> 
> He still has one splat that he can trigger but I can not. Still looking
> into that.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
