Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A54315A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845630; cv=none; b=Bre4dzV2PpbgNylJ93DP2VMKYzRs4Oalcx14b5s/B08wrKR1yoo5eQJlAzbnbBuMwnyEf8ZK4+v2u4Lm+v8QOnh05uaUuC2X8gJM+NC6KQPV5uzSGm884mffzDDpRr7qy/h8yXMgE8LVQzXFHZwP7p2OeSi7Fr/KQ+OiXQnGEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845630; c=relaxed/simple;
	bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4n+7mZfDz8iqTfuhUsDB087t/DkygBbLX6IePoEMewEpmh1EDAHfsvqQYLClphGGRqunBtTFqRfR1k7hkuz7cnNcicpWNsxZCVlBzSAcN85kL6/MOqGASeqYKy4d+vCHkch5g8wflDxpJ2cx4fGHW4xY0Cxyym1RMVitz1xqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WqlLhH9O; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WqlLhH9O"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso6324944a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739845628; x=1740450428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=WqlLhH9OWfdW7oxlmQ9M0HGCyvSjcu9z7Q0uFyOvC8qhY+b+NRzz2L9Fdhfbf4qqzL
         +/XeWl6l/bLcgZxxd7QRiFKEQe6/wt11fldtwEY9Vigq/jzKys9m2vbUuyXxJbWh+0r4
         dNWpffqQbEafKI9B0A+V2Ouj9/jGr032JgpmYIY6LYzkkOr0KLAJJhB8Mc4uVpQDipvF
         K/f5cqGmZYrUw7Q0+pCwrnr+prVEMiNW0iSMm9x6tWR5feJBd4JNkkEUbWnbbcJLzhcM
         Gbm56W/r0cqcxzdlK8nx13zyozsEZAygo9h5JKlwU7YgIxM1uzSPV6C4ep0i3d9XnER1
         fnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739845628; x=1740450428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=RNOKwlXihSgTjCvXny9gR5WgjwzUd4bJs0F1hT5lfAwL+O85beFxZzlAuBf9VaD2+G
         kzktl+RKXbUgkY8BivsrMsKh4OZ8y6viHUxy8fURbb8CWodxn3t5RmR6HX1KwZ8/Cw2r
         AWdj3xduNa3ao59NXsQFZ7P5lKI6UnkmzDL7MsvEY3BIJwtZwKIc4XE/T1/+P9fgIXbW
         wFwT0AQaVqqoyJogR69B0X+xCjUmNAb2nN/lA7REKWvQSCcqkU0UEI5+DmiJRUvvjxOe
         E9nI/prMaeThyxCTA4gTJ2X5/Yz8HfHawOPDyDGm9Qv2fn3kujo/jG//KXEjCFCXs5cp
         3kVg==
X-Gm-Message-State: AOJu0YzRgzx18GzJzQx9LuIBwDfZ44SV3qvtbDdYc3gn3geWxeFSN3QL
	6MraSSRsrcXvLQVqTAcjSckVbLnsYN1sSj0L9zETDpc0LHWCR7diE7LGrfmzg5Gnbu5caXwA+b2
	ZdVodF0X2CpF4ErDOsYHSH6zKdvGh6DNZ
X-Gm-Gg: ASbGncusPgHQiAi6gomi9uq8VsIl7prJa0d/PpB0SIJSiKeEIvzb9ZOGf4b21X6DFxa
	xyueyp97TMTYbMw7W61fcNRZUINFf2QaaERENEJDmFREXmJexYJHoPZxlhfazjPt+CoZny4BvJF
	T0F1T1zh5suF8qf9Jzi4qAKB1uGguEce7+3tHaUgCPlIbQFxSoxjDJ4eYQY1Pasm0zFn6jXOl0v
	1xLOZryaUVgq1WQMlRPkeSgYTVdK5IwUFvnxXp1DhutLogtjDQieh12tDJ31lkUm77NU7tokkbi
	1nDjbJkqGjwX7BpqHnkhfyNZApqaTdY5MU1r8+U=
X-Google-Smtp-Source: AGHT+IFFsmcWjjCoUpJdI8DVltS/RAsCrCDYNhF7gxUsUHOmvhlTvF9lASrmxXF2Dsj9RkXrgNTuPvfYKXXF
X-Received: by 2002:a17:90a:fc4e:b0:2ea:7fd8:9dc1 with SMTP id 98e67ed59e1d1-2fc40f22da7mr21187725a91.18.1739845628055;
        Mon, 17 Feb 2025 18:27:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-2fc13ba74d4sm599877a91.15.2025.02.17.18.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:27:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4617E3404B9;
	Mon, 17 Feb 2025 19:27:06 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3A15CE40F89; Mon, 17 Feb 2025 19:27:06 -0700 (MST)
Date: Mon, 17 Feb 2025 19:27:06 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: improve debuggability
Message-ID: <Z7Pv+hD3AOS/ymFI@dev-ushankar.dev.purestorage.com>
References: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>

ping
