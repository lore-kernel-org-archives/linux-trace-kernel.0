Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89257273F9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743402639; cv=none; b=qhxqRiA38DTkrTU5hQGYpn63DWsPtG8/TkdUncaEeAtUJ0k+jIowe+JHn+k4tBU2R323FO/TKEo28hogHosrUQtqJpWOYOrNWBM5A/zK7SQtZt7XyJSbZH1rbgGMSY77tl3SNW3hvI4MgSTNikyFlTYYzf5sg0yNRtayD4Awa8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743402639; c=relaxed/simple;
	bh=AeZMObkK/QaazZiyudrvlCu5jNXsOijFIL68Q4aIAQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8TIFt2WKDqvt8SsA5cPpU3PnT+22+U6ZRDa1lHc/iMwndlJT2hdZ9MsLNOFFhx/98oW05tBKRSk7RM5K93UDSh5M/7d/6TFSo+G7FJyBcH/22Mi9VTHgbLeYw6+iRDLn2DUoh/1ug1yc+fjoewQRJKaC9nq1+NwMG+/GBNZ5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RriLnla4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RriLnla4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743402636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhzPoniTfYWN8ZgDNTklznq2jNHJBvJOb88G2T5SmQ=;
	b=RriLnla4Rj4CONOThog+JWuwhBflSjMy7cmTKXiqxFzb8ZeIhZ6W8cmTCawy52W1LBrC/4
	KYDd1kHcc5eWCaRcO8VHv1aEK7FL8vBWID0qDnQLItjAVMJx5DZhxXLkr8+6eTmb6KKsWk
	VXCwOlzJ878qnxVFQGsVNqyNCULZNDE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663--3wGI-LXO5SOWc8Mh2xBCA-1; Mon, 31 Mar 2025 02:30:32 -0400
X-MC-Unique: -3wGI-LXO5SOWc8Mh2xBCA-1
X-Mimecast-MFC-AGG-ID: -3wGI-LXO5SOWc8Mh2xBCA_1743402632
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac293748694so389889366b.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Mar 2025 23:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743402632; x=1744007432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMhzPoniTfYWN8ZgDNTklznq2jNHJBvJOb88G2T5SmQ=;
        b=r+xZiXfcGoi2cWRlurfaoltF5WI1aZtJpCg4hnhH3dWzHC1TWhGbHFMTQfn9SJrqnE
         czftm7f4qcFvlbxJIj6pT5iPZ0x4YJ2QwhKMNlS7W4qoUt9TNWrp6dkTZPQQDdYhMfXh
         dQgqvQqh4WEQCR+dLZVP1mDww6mBbObU2kZQ4vRS7EDcIJ3Ca/yHUH9AhSbl+u6V1kX9
         0/xxBStP7BXn2glHjlXY13SwSQDfUDyKU1fPGIgvyvt35ON7Z0pDzkRzTVc29gRDf/Cx
         mil/SXwu66JgsmGrA1QpQwJsIeD0YTnrHCi5K8O70pQ5zpxf/JvBG/5ni6CPFkoBsYGA
         9a8A==
X-Forwarded-Encrypted: i=1; AJvYcCUUtAF53DhiQ1r7wzTSkYKaNFdxnpzWL4zLXxZ15OcJUugaLtpjoXrsqWMQJSYnu1HCsQRkVpvQwC1IBvqwuNAvLm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlDlmwXbOHNDj3o5G4TSWiXmpACljIaSt5VuSaQu3iacPxraf
	msMhg1KX38b0LmtIyX0oxPXTfjtpYqJJ4AOulDl/ZWC8XlglJoNEWh92Prw8mBj+9dNE06pMrzW
	SiBcB1P3XH7aslDfvIC6CTVQaMhsvRAAM+ESkbE353yllf78Pkt/Inreye8E8U3lX/F7LAKv5Rb
	L5dqvJtcpaM8kZUkQ6tLS+oYNNx/OjQnjPE/t0hrQHKKnn
X-Gm-Gg: ASbGncvdHuh94cYn054ypZlZIeCLRkfgjStqHe4gBrBwhgLwuT4MqghQpSzxaroZGiO
	BjpmCXbG9ZqOAm+x579eQKyWDI3MXtP+J0OfS1PpNA/ciGc9tPS85D8VWaaFGm6sqkFW5yoVxpQ
	dAbUc15kzOcF3sjxQugu92xGUPQ5Y=
X-Received: by 2002:a17:907:9693:b0:ac7:1705:a86 with SMTP id a640c23a62f3a-ac738a0d32bmr719197066b.3.1743402631713;
        Sun, 30 Mar 2025 23:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6RdegHcqRaJjXTmFs/i/IFW8n/N8N4TD8XYvjQCcFTYTt7fKCRVjBhw4dwhhumP8ELdRR0n0cNgI1/jOzk7c=
X-Received: by 2002:a17:907:9693:b0:ac7:1705:a86 with SMTP id
 a640c23a62f3a-ac738a0d32bmr719195566b.3.1743402631338; Sun, 30 Mar 2025
 23:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330184641.1929409-1-costa.shul@redhat.com>
In-Reply-To: <20250330184641.1929409-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 31 Mar 2025 08:30:20 +0200
X-Gm-Features: AQ5f1Jqff5rlw4TphOFCW4Jy7FGhPhZjVYJkSlX_qoNC9iL3ocvhNvNB2I2h66c
Message-ID: <CAP4=nvS7nAfrMfb5L8A4DU0ZtGY7cxVD9gTLL-xV9jW3rU1rTA@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Set distinctive exit value for failed tests
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 31vKPYUVd6TSqjfXQLGbR5f9wWbwZ3J10UNYLTLArQ4_1743402632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Costa,

Thanks for the patch, this is really useful, as we will be also able
to test whether rtla properly resets the threshold option (see below).

ne 30. 3. 2025 v 20:48 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
> Failed tests return the same exit value as passed tests,
> requiring test frameworks to validate results by parsing output.

Please specify in the commit message more precisely what you mean by
"failed tests". That is, when running rtla with threshold, the exit
code is the same, regardless of whether the threshold is violated or
not.

> Set a unique exit value for failed tests to
> allow integration with testing frameworks without parsing output.

Note that this is not only for the test framework, users might use this as =
well.

Also, users might be already relying on rtla exiting with 0 on
threshold violation. What do you think about adding a new command line
argument, `--fail-on-threshold`, that would allow the user (including
the test suite) to trigger the new behavior?

>@@ -20,6 +20,6 @@ check "verify the --entries/-E param" \
> # and stopping on threshold.
> # If default period is not set, this will time out.
> check_with_osnoise_options "apply default period" \
>-       "osnoise hist -s 1" period_us=3D600000000
>+       "osnoise hist -s 1" 2 period_us=3D600000000

In the future, we can add regression tests like this:

check_with_osnoise_options "verify setting default threshold" \
        "osnoise hist -d 10" 0  stop_tracing_us=3D1

This will detect failure (return code 2) if the fix in commit
0122938a7a ("rtla: Always set all tracer options") no longer works.

Tomas

