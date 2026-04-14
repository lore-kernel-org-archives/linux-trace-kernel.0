Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C329DB9A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190038; cv=none; b=A8XlHslI8Adpz0w4M70Hjl7ua9akCDsXTD1t07Ch94dyUbqACBVs4nRDDJX8ZeMeAUrAPWAVq9NfiV8yeA5wdtpXDEXOLhy+fJY+5rt900Lipc/TD5FMq9edKA2rnKDyHbRdZAXW53vYT5qVTCp/CJ8A4b7/FYWnptkMie5RaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190038; c=relaxed/simple;
	bh=eEb/lB1KUyn1kADF0Y41MtKSFWEswdFH9DeVlSb7mYM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWqnI8QSGFCXF4kvDYGd0i65TcyFbpyWuJKlO0wdnP78Ij3WGcns3/kJ7B70qOf2Zcyq6kwLwoCV0LI17P9EYp0Ff1ldqO1s8ZgcOcuDgilvRZQwR7IiRhG7KP/7yUbzR8I2oXWd1hyB2swOOFJldOfNgYZ2DQHH63+bZHFz2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNNpeyB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNNpeyB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776190036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEb/lB1KUyn1kADF0Y41MtKSFWEswdFH9DeVlSb7mYM=;
	b=GNNpeyB3p1M3NkeTDJ+46EMSu3QHTs0zoTwlAxi34Ars3YB2UkuvxK3p02lJpXSJKCJjx0
	dRShA4irQvdoJgyd3YMpNPx86PVttEDifc5eiGJsX7/yjDRoL/OUkepL8c2fbea4zZD2AQ
	cg7r9x0S3+wdAZuknDwZsKUFBiq3/8s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-llVug8S-PAmRjSc98eCZpw-1; Tue, 14 Apr 2026 14:07:15 -0400
X-MC-Unique: llVug8S-PAmRjSc98eCZpw-1
X-Mimecast-MFC-AGG-ID: llVug8S-PAmRjSc98eCZpw_1776190035
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a275472d89so100373636d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 11:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190035; x=1776794835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEb/lB1KUyn1kADF0Y41MtKSFWEswdFH9DeVlSb7mYM=;
        b=SzSWV11xdqwIyphCCTJ4vO00qNoOk4rwYRSgzMNvWsvySnSTo8KU5OGURebMFisqI2
         OnDuwVnO4XseX2L+cbyPGGfRusDA+tGPrjr8CFOaKhdnTiyRVRarP33lIbJ14Gk2N+4f
         P55WWZN+5PhXynG2bRgqncP8j/UXJC+1NIUuylvPkpfZvzMAeezOi7ANOZiDT2oOSgG4
         l8rERhvyy9zLR+mnRYdub9kYhxz/8ekxksijYUTylS0B/1h0CVERWOjQwt1LMX8sE4ua
         /ClVRKPySxc/3OHrIyPYAJTGsY9+FOSEozqPr1rSoollGm9rdePcq0M1sC/KaRU92viO
         opCA==
X-Forwarded-Encrypted: i=1; AFNElJ/myc57b8Zqt0BPRxhbmQNPZwYDn5s8pAbRqI+RIc/4CEf7Jd2p7gUK44H7OBge4cQxnSYVDOQJdRS6Q+tP7S9v9ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIVGs0RnLVdtnkpbNWiajPY+YTWu6hyiPsjJvBdqsydlTf1oh
	61+2t8xeOaHJd5Uqo8CB7N4HERgxjWXV8vOhLTxoJxtBP8jY+p1/PPBwDI5K/IWv2WwGUDmWO+U
	SzVMb7r1wefvm7H9xXLpNwoZJQNG0+bsqaBmiZvdwKFR5QxSxnwVn6cBKZAB+5VwB3YQw2p2GeQ
	==
X-Gm-Gg: AeBDiesGZnIW2SCqb+hHf4fpqtvg8IrEu29L+pcGCpz2QdjE6q2uQdA7EH5JUZP5Vxi
	rO+ltXv4RcXpQRmqdw38VOyycaPdw1MfMUcrVGE5KUuYZiZx78FTskBfOu++QGoKDIR26u8VDiN
	RzIOwr8/DsfdEILLIf4dSkDb7QZV3RR1rIkc9GDVv0pOudS6m5xTloOt+F9rAUMtGfMjhbJaG2v
	z8PwFZs9bF3yXdYs/SUc5bB5RyGhTAgq2EEcgEGSg7Q1vag3DiaR5OE6EePUUNg1MJjtmHfMU5O
	vQJc+A23EoQGdKq02FDU98jWFZxAQ8VpfMxjMrPxkjZcEAcFXtvUTvO0/wK1JDbzivw5/s8rxxa
	Dmax6gIyE5GMO8R3QgFkHIDLQX1PdSR8nS+LEe1/9UIZtv9I6mx+egg==
X-Received: by 2002:a05:6214:8008:b0:8a6:efd8:9b30 with SMTP id 6a1803df08f44-8ac860c661fmr259886526d6.6.1776190034805;
        Tue, 14 Apr 2026 11:07:14 -0700 (PDT)
X-Received: by 2002:a05:6214:8008:b0:8a6:efd8:9b30 with SMTP id 6a1803df08f44-8ac860c661fmr259885826d6.6.1776190034183;
        Tue, 14 Apr 2026 11:07:14 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e2891sm162232916d6.5.2026.04.14.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 11:07:13 -0700 (PDT)
Message-ID: <e5d69985fbdcacbcb47a1643dee0036ec93c3a06.camel@redhat.com>
Subject: Re: [PATCH v1] tools/rtla: Fix --dump-task option name to
 --dump-tasks
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Wander Lairson
 Costa	 <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Apr 2026 13:07:12 -0500
In-Reply-To: <20260414140621.28027-1-costa.shul@redhat.com>
References: <20260414140621.28027-1-costa.shul@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -fnBFmkmfb6HF0mfFqH8eFvY9VbhvZ4VDh_m-ZDjyaI_1776190035
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-04-14 at 17:06 +0300, Costa Shulyupin wrote:
> The option was inconsistently named --dump-task in the usage
> string and getopt_long table while the actual implementation
> uses --dump-tasks. Fix both occurrences to match.

How is the getopt_long table not the "actual implementation"?

Wouldn't it make more sense to fix the one place in the documentation
that says --dump-tasks to match what the current behavior is?

...except that apparently timerlat top does use --dump-tasks[1], so
maybe we want to make that consistent, but the changelog should be clear
that this is an interface change for timerlat hist.

We should also probably be making sure we have test coverage for both
hist and top, which would have caught this, rather than picking one or
the other for most tests.

-Crystal

[1] Oddly, timerlat_top.c is missing --dump-tasks from msg_start[],
which is the one place that timerlat_hist.c has the plural --dump-tasks.

