Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F51DE8BB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808810; cv=none; b=DD0gjh98c6d1HTMv3ZzhtqSk601rYTfwztu4ZeAjtlJO/1Hmpc0AEOtZYzr/UMeXZ9msjzoxB/FEfTXGyNJ20PfF9mkf2kYYaVMwrV6ubXEvFF613gXw8SwUZYioYWxsiRgIGSjWskuSirTfI95mVDR1e46QnjvTk3Bs9DMNF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808810; c=relaxed/simple;
	bh=pfJLtE9sNrRsr8aJJeZjoYBGIo41nggVe/WFiRmbh0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nSDq+zwoQUbT8COulTct9SqJeQcpy/7CXXMSGJn8KapgXjvv9avgmeKz5UUd5fx2ijvCw7gPHwDbGiZgKxFl9QuUAtl6memPypLwtgfOZEt7Nl0OA7zheU9DtNHddEX5szRaSqw2CwxVWA+LkSUNHbPxq8rU6L+UNWM2s8B8xe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFanpsRm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFanpsRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782808807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfJLtE9sNrRsr8aJJeZjoYBGIo41nggVe/WFiRmbh0Q=;
	b=DFanpsRmmymI1CD+e7vyoFVPOtsWJ2ui0XLUgGAPJCb5ulTAycG0NhReXkgGxpQoWVv7HF
	2/DvD58g968ouwSSjJ7lreKuOCfX8fJXvrOFd0uS2tSraw75FBzx4lhhCVx6nKoYd3gfht
	30leY7XWmQWC92xmhXyJ+ASvXAOUr9A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-Vv1c5uwyMZSeATReHqInGA-1; Tue,
 30 Jun 2026 04:40:03 -0400
X-MC-Unique: Vv1c5uwyMZSeATReHqInGA-1
X-Mimecast-MFC-AGG-ID: Vv1c5uwyMZSeATReHqInGA_1782808801
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E1AF180057C;
	Tue, 30 Jun 2026 08:40:00 +0000 (UTC)
Received: from fedora (unknown [10.44.32.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9ACF3195608E;
	Tue, 30 Jun 2026 08:39:55 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jun 2026 10:40:00 +0200 (CEST)
Date: Tue, 30 Jun 2026 10:39:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Windsor <dwindsor@gmail.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, shuah@kernel.org, rick.p.edgecombe@intel.com,
	jolsa@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/uprobes: Keep shadow stack in sync for
 emulated CALLs
Message-ID: <akOA1xldL8FGWpwp@redhat.com>
References: <8b5b1c7407b98f31664ad7b6a6faf20d2d4a6cad.1782777969.git.dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8b5b1c7407b98f31664ad7b6a6faf20d2d4a6cad.1782777969.git.dwindsor@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 5o_kUvn09bHmL89-PnndTkt6N3dTJMFwD83VZoXZmSk_1782808801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/29, David Windsor wrote:
>
> Uprobe CALL emulation updates the normal user stack, but not the CET user
> shadow stack. The subsequent RET then sees a stale shadow stack entry and
> raises #CP.
>
> Update the relative CALL emulation and XOL CALL fixup paths to keep the
> shadow stack in sync.
>
> Fixes: 488af8ea7131 ("x86/shstk: Wire in shadow stack interface")
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Acked-by: Oleg Nesterov <oleg@redhat.com>

