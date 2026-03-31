Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594913A7840
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960349; cv=none; b=LecQmaN1vCP7VcotHA2Nl9UBmRtVmHeWxSYFUqlD4UjHqqXuluh0uQbqXd7vACM1Pb+e22VZmLR+XLP261Yh0hADcW0c4S8v/rG0vxVZP1LrPvmVYAVn6vOVnBVrw5AtTfRrdxlvi9os/vUJrqXQIpASN5AGPZM7MQ39hocxSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960349; c=relaxed/simple;
	bh=cNAikEHCkZVbXV9L7P9K7rSvtd8mDS7n8ChYvIbvV5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Rzyon95lFPXkXrR0X1cAfwW2lfY0WqNIVoEdxSMtkG8sUJUvkV6pYx1VGmXAA79cgH8PRP0RIB+COYgbVmY+KVIAtr6YYfGqKad65Nx5Ryrdkk1SIChG96fszZDeWmqKnR4N04wxplrXeyFZGcXgLJ7eEfYo43y31C6FS07QsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYbq5O53; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYbq5O53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774960347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgrfduhaMhaQEbDK1fgbyKqHENYWUFIoiUzS0pqdh9Y=;
	b=bYbq5O538ljMpHCFHWBSNIff4MLZgHQ8Vxz7fqlDZZxAyhhrU44ycNNdp/Y6Rq9m7NUohh
	F83geqTZAi0OngAsG7LfOO8FESxeMjqlfiPe+UMv6P38S/9axDPX3CxG7x4Wg0Usaafy/7
	Tv0V5Ob9nvcmdIcU46H7mH0crwnosjg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-4ZhsjZ_jMfihY6E60hAQPg-1; Tue, 31 Mar 2026 08:32:23 -0400
X-MC-Unique: 4ZhsjZ_jMfihY6E60hAQPg-1
X-Mimecast-MFC-AGG-ID: 4ZhsjZ_jMfihY6E60hAQPg_1774960343
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so1169005f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 05:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774960342; x=1775565142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgrfduhaMhaQEbDK1fgbyKqHENYWUFIoiUzS0pqdh9Y=;
        b=DK/BrQXlgHEVyDJie+lJggkSdn66EpagoDO83+jkoRXghJD6slLMaN0yp4PTyk8CFL
         yKltlyS87VKrU2rAeNC6BH8vmyU3Gsk8HfJA5AcnzpKvDACevnpS+3OuV06tLQheyK8z
         sDuBHT1a7v8xAlRhihlokO9ny4ml1X+wROgO91lWCf15BrwU44krp73fbGBW0eUPqUcO
         75dLkcNI6bzWA9Lyehh/Vh2Braz3kPTk6QOxT3Eb6coLKs6VvLU4nuNq6/Ww4b6/U1G+
         zou9YrfO/kNTfQ1lmunEATqB0oXqL3G2lOOB3IwQtNizjMb91lj8tAeAsf6VSY/EVyoa
         NB/g==
X-Forwarded-Encrypted: i=1; AJvYcCXhA+mbB6ylswh70BVnjtkn3yRpxfIfYnA1Zr0Nv45Omjw46r2G25IP2omrlZh0vpjz4O+TNL7ins5Uwfpjy+KHS5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckyNoKPG1L/hkvDM72N4SMOzZPIPEuLHqwo/pQ1GHQWUhJd10
	4TfCkotpACM4vDzPNjeh1uXFtWNYuD02PSuaPXsN4kal1knDSJKJUqXV7sftnBG9RjOF8ZPHo72
	aTnXin3lPekMFRGPczey9oWSA7IcbST2zboIxsJVlhQZkPQ8ntBfZfDlljCEnjdDDybC8PuUcXw
	==
X-Gm-Gg: ATEYQzyP72/uZLV9Jn1Mq7uD461YBy5NC/dbbsT70yAHkcr2CTwA2uoqWmaMnE4l2ji
	W9CHw0iudd7JiiLLertyXeKmzVMciqbyu8sst5ibv+kUloT5O3qJXJnnaathZRIGN6WH2hqxTFt
	UeYHz3GfZ7x66YvLkDyUxmMHGvWgOpZVC5f99Tl6dv0xDlmgQTpZFISayAP4aeYpNKYaEla7f1a
	PkEvo90g7qMENzUzPz32F2s1enmf2fB6EXXnweYokqGSCel8ASW13u5uZgUOI4zV/x5eu6+Npch
	ycTiwQFAQGEdEGNcSUg6jQSTMf42n6D571ax9PsCkrgZ/DnoEInM/IZZ8p0QGxwsdhBVayObs2K
	eOyNbAekD0c/9zbL5OgHPlnNjNaimmVHM3kK5MXxMOg1s3RHfzFs=
X-Received: by 2002:a05:6000:2011:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43cf3c93863mr20177968f8f.3.1774960342485;
        Tue, 31 Mar 2026 05:32:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2011:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43cf3c93863mr20177899f8f.3.1774960341966;
        Tue, 31 Mar 2026 05:32:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.82.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf257b72dsm27221882f8f.34.2026.03.31.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:32:20 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:32:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v8 12/12] rv: Add nomiss deadline monitor
Message-ID: <acu-0lUkjGMQbsZ1@jlelli-thinkpadt14gen4.remote.csb>
References: <20260330111010.153663-1-gmonaco@redhat.com>
 <20260330111010.153663-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260330111010.153663-13-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -mn-BS841JglrEFDHh-qxXkwIiOzmL1rIQVmudV2Raw_1774960343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 30/03/26 13:10, Gabriele Monaco wrote:
> Add the deadline monitors collection to validate the deadline scheduler,
> both for deadline tasks and servers.
> 
> The currently implemented monitors are:
> * nomiss:
>     validate dl entities run to completion before their deadiline
> 
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

