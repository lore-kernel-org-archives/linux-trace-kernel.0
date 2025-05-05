Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671F24DFFE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 May 2025 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447951; cv=none; b=U7YLF+m7ESqpvVeVftmV6Jl3CUHv3zad9LFko8ZgZcvr9tI2pZSnanMvkdMf+RSYHgQdxkXmtmlzLc+tr1Wbe2mkN+SWMkFCgQSe54CkDN1xvFvDfZOzb//+p2pLNgu3j9MCSipButabnAAD6XHMhObO2iNBbgYjZEBAdwE6aYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447951; c=relaxed/simple;
	bh=dM29SgxV4uJqOXwk6Y/1r+OBrOu+YGmmKgFsQvUqo1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAraB8JnStKgdrU0F/rFpVp2c4dds3QVjlyqA98Wl9R2sWdFJHsD0kiQ34j9n/AmjdfLTsm5Du85er5ENE6OsxHgENnIilBkidCDmMxaq79lpwOWRWGYnABIPMDG8q3V7byOBUhOw7QRLRVJomtYk84lS+wfCGB+/fMZE8MzkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BCUuBria; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BCUuBria"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso8637212a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 May 2025 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746447947; x=1747052747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul3mmPCYXNLg1qFjGH68tfe8ccOUp/QNiNXPNMQhrj0=;
        b=BCUuBria4cP+O0SHagqdmWJ8OGA64FkXn0HT7Ksj2CTg8VAT+eWs/CNZRPVfDqH2X0
         2QbhU+Z8oMX8k3nyAJtDE84X2ioLVDwDZU09fNeOV9zb7J7ivqqdPOuSEcclOx0F9HqK
         QvnUpd37/L3658l27UhWCcLeh7MOLMglNpSx7XwP6einxPsih39Mm00+W0C32NDabE1w
         bS98F9A3xdfIbiWlP6Uzc28ppZy0yMYOkVAp8wag9juIkH6C9xwzMIjCdEQkxsEGW7Qp
         ynJsGmrYmJIKux28qKZnF8kQyWFb8ipTBpQQeiCnYv6U7HFAAEifiwc0XzrfXmpRD4Xl
         BDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746447947; x=1747052747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul3mmPCYXNLg1qFjGH68tfe8ccOUp/QNiNXPNMQhrj0=;
        b=g5QO9u0VQU76G/TyLBI5x6cqi14JzO5EDDamk+clLnSVIrUgUUglMub03RakRzWjwZ
         RzYTHzTA8j+pkHjyLNlxH2bu5y05HOWqoGhKIiNFFDHXKF9m8QFtkdhphZymOb7ykonZ
         fnmnWDO3hsyAKfvgZkQKRRRsdxXnl24/VzLy4ewfbXa4M+0lcOmSk03ZrBLqk138wzir
         +wnQtwd2R6FGVFQ09h2bSjSjH81iljZ9FabZuEG1ADbnpr520K6XWjek/oC+XL7+x3J7
         hHMtmNYNmW6L1dvHJ2MPOPWhNb0GephY8BnSzzLgiS9TTewZIVokuSO/+XrWw8C7ykM5
         CYhg==
X-Forwarded-Encrypted: i=1; AJvYcCWKZssNodDEUepE3ZDz44xbUdh39CCPpqQN+ZkbWsZJo4o9wXS40whctAmswp9rfZ7B8onAAN3hAdfiXd2O4nSy/IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEiXSMVw4Bq5dayJ+2wo17Hh5cU8V6M9I9BNK8M9FXigW3++Y
	lMLVlY30Rc+pCIyv61cNEOyvSJ/S1jV4LBnyytWduv5vjZ/oVGfESgJY3eC81L60ST1P0qk4rtV
	l
X-Gm-Gg: ASbGncun8fLMzMsGGX3CLxncPZF0MGfHfOb9d4WwPNKUgO2xLK51XFWWFEKQdPhtya0
	bqqOi3FjPAeSKgZvahHwj7XVac9M8/SmKvYlM2WFAJka75pl1ex+Rsm8N7Wmki3bFlEniRXmDGT
	FyrFhnAv3a7yPVs5zVH3tIzcZh4Mr3Bs7KoSLj4FC5ZSpm3XnerA6CapA4Qg41mql0cKfQVOVs1
	ZS+ax4lspRdNnzsZvdy7CpRcznSVfl/T7kdv7EGLKTBxsaM/CWR4sTNaAPyM70vlK65N5ExmIty
	JtJjIAe1cEub5JmXcKmrI7eAJOjUQYveRKxW3pXmeR8NUSVbd+A=
X-Google-Smtp-Source: AGHT+IGJBYHVy0S7abha8Y0YbDnYtCH1096cp+aOxiQt/wTq+YnGfjzVIb9quv6PqCuPc7tysxT5LQ==
X-Received: by 2002:a17:907:8dcb:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ad1a4a8d95cmr669318066b.37.1746447946953;
        Mon, 05 May 2025 05:25:46 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189147431sm488354366b.8.2025.05.05.05.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:25:46 -0700 (PDT)
Date: Mon, 5 May 2025 14:25:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v6 04/22] rv: Let the reactors take care of buffers
Message-ID: <aBiuSckTNYeBvkKH@localhost.localdomain>
References: <cover.1745999587.git.namcao@linutronix.de>
 <833a4176f178d5d8d0acc40237e82b22f4e3c027.1745999587.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833a4176f178d5d8d0acc40237e82b22f4e3c027.1745999587.git.namcao@linutronix.de>

On Wed 2025-04-30 13:02:19, Nam Cao wrote:
> Each RV monitor has one static buffer to send to the reactors. If multiple
> errors are detected simultaneously, the one buffer could be overwritten.
> 
> Instead, leave it to the reactors to handle buffering.
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

The patch looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
