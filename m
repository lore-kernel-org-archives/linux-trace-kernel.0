Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B31E2834
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031604; cv=none; b=BTxLGpPTnamUxIEa/UNx9PlddvQKJdP1sycvbj+IQGoACRTEIwXl2BAQZJn6HwqUdRCB521S1OG/osZYH6bASWaKl3kFnSLlZMB7Rsise3bLM7GF7dm8dX4J3ci/zxBBPfBZQcLaj+tpb+jz67OgRfTNzSQEFVSH7OIVFncoH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031604; c=relaxed/simple;
	bh=y+wafNRdOeJoV2adholJuL8OeSs6bKVGXusWa7rTBys=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3TFRpzJdIUaZNf1TgT72EvfPp8DhYubc17oqP8QyfsC9j72XKI02wHVuZgzhcSlxDY7A8AGfTaS2yqe08LOIkv152ukMgry2WlP5iOWgyDmH1/dkrj7RXQWSdoYYGv3Q9RRq/nacw2o8d6rk3Eq9/7aTD1hfa1PHetLoquj32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUA9DJj7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUA9DJj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764031601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSpp+DANB+wjWaaNT9fDc8gzwADBY/l70nNl6IxbdP0=;
	b=cUA9DJj7CKVwIZM4yJTeqSlaiinPtryXNyYJeQLRW6KEQ4o6jinbFBJaXfiF0H4XOLT1sm
	16TcxDCN0C0uSzMkIU/fBMuPlONTOWrGecXGnlMthmgQmgLKM6JibogqGrYXdaSmDfAFlM
	Ne1GpMHA2raZvvDyO2m5wjg3V6ozxSA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-2yW4DnDnN2OC5X4EjSXAXw-1; Mon, 24 Nov 2025 19:46:38 -0500
X-MC-Unique: 2yW4DnDnN2OC5X4EjSXAXw-1
X-Mimecast-MFC-AGG-ID: 2yW4DnDnN2OC5X4EjSXAXw_1764031598
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88236279bd9so157009026d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 16:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764031598; x=1764636398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQNtnWOsotCA1HNvoVlP0i2b01R7aawce9e6oJOL594=;
        b=iCynX423MUDt5IZmi6QxuysUKrch8oXdrBn2bnj5dNedeXDWNZ52SavEN0CI0BB8rf
         aCrzvo0zO33lTfKK94/aq3tnD9TQPxHQwBhZpkGlADpDzItzX48yw9CAqN+OHfL6WZUz
         P7tjw/matGeb8w9yjPHTTNVbOTOyXj3axFi5PJwkGwtnuUipGA9yKT+iJV/ElRXcinrj
         PQRsCs2o8qw7OvE9sgcR9i1sgoiSZbntXLi4vMM3UbBPU04JoTzwo92kqPi+AArXcDxJ
         x4M4AIOxpPrT5d0hEn6MzAeYxmgGoJeCacWZ4yCDCQks9fXaj/NZIPLi1kUhGlZ5VCwp
         /EIg==
X-Forwarded-Encrypted: i=1; AJvYcCWOSf/opUXrGRBVm3oG2Lc7Ig24uc39qv37GcSH+jo3WyJOh/wZiLEQ1Zja+44wK8GCR3S9wjpefNkw6MKFzO1DoOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZpiDiP6tSH5dSXiZoTuG3QN5+NBtmXuVpZWAykx9xlsmL9TJ
	lr24RTyjwtKlX7qUbjhZUK9f2LRttkfC0xRn0jzjuU8hbKKRHc0eFsTd2SrP+8jqpdgrvGAmXI2
	+W20BRfzL1kmOUqi7KWhOmg6Zafcb8LgDDAKxHffrdN0CwhOF6AQk/eHUsNdGJVZnU/gZPAqfgg
	==
X-Gm-Gg: ASbGncuY4gmymLbp3pLgTgttyWJmUf+GlZgJ7YgEGF9xNpU/626X9pr0wQvA3YH2cI6
	nfpUM6vL/Rm2+ZtpTY/TjcbZzf+ME4yAbwVSHhkAxub9FlubQZiwOEc7MjzBSBchdy/sFJlR358
	XIkH/fcOLd9ulIr4O/9k8+v5MkCjG8vmz44AAliuIpWTn6KFiB6rwNMax4QTMREf/Iu9koaA1B3
	Ok5OC0W43Iyn+rtkGM9nrIzRuBpsBD4LrcUEePCROVICETxhHKdiGvxcUhrKyvP8MX3sNK7z/uG
	JmYxCLjVHR5lVW51a6MiGhDEcMU2rxiuL4D3d8QIU9DQDdcE3YpTqJHhur/hTBGRhhLEXmgoy3z
	Gw4EcIJMi+8Oh13FX4tU0hWFRnNBk0Y3qYGXLbLfdXw==
X-Received: by 2002:a05:6214:4a09:b0:882:4901:e960 with SMTP id 6a1803df08f44-8847c4c8123mr198048816d6.29.1764031597825;
        Mon, 24 Nov 2025 16:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB5+f1yDnZK7hRMic4Sah4dDpUUJqEdE7scW0eh7drx/bT1c7yAK2y5dCpUKma/dEfKV08tw==
X-Received: by 2002:a05:6214:4a09:b0:882:4901:e960 with SMTP id 6a1803df08f44-8847c4c8123mr198048636d6.29.1764031597486;
        Mon, 24 Nov 2025 16:46:37 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54e94csm110992156d6.34.2025.11.24.16.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:46:37 -0800 (PST)
Message-ID: <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, Costa
 Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "open list:Real-time Linux Analysis (RTLA) tools"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Mon, 24 Nov 2025 18:46:36 -0600
In-Reply-To: <20251117184409.42831-8-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-8-wander@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LtDoVgdRHoCZtJP8lwUeQqxv40_BDGgJIRkFbbVrEGM_1764031598
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:

> +enum restart_result
> +timerlat_restart(const struct osnoise_tool *tool, struct timerlat_params=
 *params)
> +{
> +=09actions_perform(&params->common.threshold_actions);
> +
> +=09if (!params->common.threshold_actions.continue_flag)
> +=09=09/* continue flag not set, break */
> +=09=09return RESTART_STOP;
> +
> +=09/* continue action reached, re-enable tracing */
> +=09if (tool->record && trace_instance_start(&tool->record->trace))
> +=09=09goto err;
> +=09if (tool->aa && trace_instance_start(&tool->aa->trace))
> +=09=09goto err;
> +=09return RESTART_OK;
> +
> +err:
> +=09err_msg("Error restarting trace\n");
> +=09return RESTART_ERROR;
> +}

The non-BPF functions in common.c have the same logic and should also
call this.  This isn't timerlat-specific.


> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/=
src/timerlat_hist.c
> index 09a3da3f58630..f14fc56c5b4a5 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -1165,18 +1165,19 @@ static int timerlat_hist_bpf_main_loop(struct osn=
oise_tool *tool)
> =20
>  =09=09if (!stop_tracing) {
>  =09=09=09/* Threshold overflow, perform actions on threshold */
> -=09=09=09actions_perform(&params->common.threshold_actions);
> +=09=09=09enum restart_result result;
> =20
> -=09=09=09if (!params->common.threshold_actions.continue_flag)
> -=09=09=09=09/* continue flag not set, break */
> +=09=09=09result =3D timerlat_restart(tool, params);
> +=09=09=09if (result =3D=3D RESTART_STOP)
>  =09=09=09=09break;
> =20
> -=09=09=09/* continue action reached, re-enable tracing */
> -=09=09=09if (tool->record)
> -=09=09=09=09trace_instance_start(&tool->record->trace);
> -=09=09=09if (tool->aa)
> -=09=09=09=09trace_instance_start(&tool->aa->trace);
> -=09=09=09timerlat_bpf_restart_tracing();
> +=09=09=09if (result =3D=3D RESTART_ERROR)
> +=09=09=09=09return -1;

Does it matter that we're not detaching on an error here?  Is this
something that gets cleaned up automatically (and if so, why do we ever
need to do it explicitly)?

> +
> +=09=09=09if (timerlat_bpf_restart_tracing()) {
> +=09=09=09=09err_msg("Error restarting BPF trace\n");
> +=09=09=09=09return -1;
> +=09=09=09}

[insert rant about not being able to use exceptions in userspace code in
the year 2025]

-Crystal

