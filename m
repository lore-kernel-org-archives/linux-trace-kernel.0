Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC338DE9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425703; cv=none; b=ZhhZR61SQzzBGT3YPLZlqiPi60XxHP/SQ/EP9T5BIc6hYRo/FU0i10Kmcu1W8E7YKVvSIcy0WjKpj5G0y2LD8Ut0NPNudntYB263kbMWbkRedgYDUc6uYjg8vjhneVXfe2Ju4tX14VA1tGaNFq/0GkSyHbMgCms5l/W9C08KBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425703; c=relaxed/simple;
	bh=9pSl4UpUltApWCkaB2TQU6IpD04bsOyRgYCWjHq9QwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCYx+WjPlD69fNVUQr9kQce3eOKsrw5Iq++ItePmmVgq3vk2/qCvAkJhKUrUgZA+2Dx/GlWfSN1TWNYfdUjut3wlRK+IPBZrieTU0O5zS3enUIwVgIwv6F+psMvF6ZpmpvZEftRHqtb85grPprjDk6XXMRTtbU2g4kQyg3EcPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TKe0k6QS; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TKe0k6QS"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-220c8eb195aso105597395ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740425701; x=1741030501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pSl4UpUltApWCkaB2TQU6IpD04bsOyRgYCWjHq9QwQ=;
        b=TKe0k6QSBbcLWljPAqk2LHJsseAL2iiE57aDD/9Sbo/rq9jLIidy7b4dz6M6+SqCuh
         FRMpdZSOH4A80mMkyrtdjKRvXtk9DM0VfUTTAN40uMB3VXIDqeb2vOhCJwXbLcypjDRp
         epy3JV2th+OQZDE4y6ZP4zZHa7psnXEAZx/JgtGpyN11AMYCidCmZSwXdQ42jSDg8UfP
         4iFMvd6ilNF7yYjRWdat4FjsNAS7TzT3J1A+9apqpFmUFdM2GpAGg3VrcWeWjjX/GP6G
         nR9fMbPkM59AxyZY3lcYcGJ+hjtDzY2rgove1QuWwnoqmMJd0z1ooH2rWAO4ewQeNKJz
         BSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425701; x=1741030501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pSl4UpUltApWCkaB2TQU6IpD04bsOyRgYCWjHq9QwQ=;
        b=m8nCOzUKDZvjmcTEOz7QHjJccUKOZcjF9XQtZ6QsVA2w8aeSvOb7FbDlp8mjR0W67n
         crlc0LY/2aFyAxtnWSR1GJsfRRkgGO8JiJMqedn/dHjfhTHyS5fT3fe9YUgv+/fc/LDp
         BD7BsND0lXFRX0AmKICv6FKWGqrdVMOpcqV3vYZgMp4X4O8ZHFRCn85M/xH2uTKflXv9
         lrX4QwUGIqLvZEooFOQNXfoaYKNIQGrBXkw1nVkIc+LurQaXf3zg/CvQ9hcjee2jg7GK
         fe+V58kHxB8ELQK/nSqnvc0zgGrFasd8ZEXK69+RyC+rUFXeD66ZNpk6nqk43ft5OLYB
         qyig==
X-Gm-Message-State: AOJu0YzRjUX4C9Q1KPe9Be17XIPhhA2thjvRRNUrqw6pb3z2Y3quXKOY
	1X3r65i2HuDCX0bf5EZLhzcwTcvX1Qbpnxgx7cKn/8xrNEB4BftHF7XjfhEaNbKn/epVhfZxlYP
	0eSgyMgK0/CRBLELQyEHuFWBa9THe/LnW
X-Gm-Gg: ASbGncuCBoLEhYSYb9XNt9/UdcQ5OXpTyeuIgYw2drJX7wFPKS0Qfr2wVTrEDdNhLgB
	LMSLjoZxKdcJM6lhOtvGFkCAd797Z0HwGLlFO9zVMdX3dEk3IAbF/gSF/mfqHPswyTE94gbwKVP
	wuXIWel27CSpFmG+F48z45ysEQHzvUGBu1nBqwhg2MVVvv3gmLu9T+3x0t1kFcArnDbSJojax9H
	5z3r4sAf8Zh4S8RuzuABvViwOvBzyFy77ZQyooDFcgHPj+FviND86zU2SJsXEf8NlCKq4X0kctg
	KUT6sXZ0GLcXwo+WQk/47QiWOJpG/MGDj1fRT5Q31IxeJXbj5A==
X-Google-Smtp-Source: AGHT+IFmkKPAJexMZBFCuDqSF7cUkV55id/jBHYO/SYW9uNccAYqjX1Ep8ynNrqPIS1as9sxoALbH7LjPbML
X-Received: by 2002:a17:902:dac5:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-2219ff50d25mr225280065ad.19.1740425701534;
        Mon, 24 Feb 2025 11:35:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220d5324f7fsm11616215ad.56.2025.02.24.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:35:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CEC243401C5;
	Mon, 24 Feb 2025 12:35:00 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id BE5DCE55EF8; Mon, 24 Feb 2025 12:35:00 -0700 (MST)
Date: Mon, 24 Feb 2025 12:35:00 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: improve debuggability
Message-ID: <Z7zJ5EjIFLbz9C3I@dev-ushankar.dev.purestorage.com>
References: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>
 <Z7Pv+hD3AOS/ymFI@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Pv+hD3AOS/ymFI@dev-ushankar.dev.purestorage.com>

On Mon, Feb 17, 2025 at 07:27:06PM -0700, Uday Shankar wrote:
> ping

ping again

