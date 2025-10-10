Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6742727E6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080897; cv=none; b=H1kOON+YTUPQ978sDuVlOck0t1b/0U7bOAxs584W9drd4m14JsRDeRV6l/9KjmZNBkOyLbTNa8lyrKVTx5W3CS+vDVtlUcI7vI66Z3GMDZuJg/CKSU4cSp+w+lWKw9FCqjk9uz82GPuCXreW4V4KgmTpjYcpgSul75MvySyFpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080897; c=relaxed/simple;
	bh=WoN0dpJjGxiZ0wQf4DNv5iwB6nIANTg2G+mNbipfa0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3qVD6yY3xBjXcvNWOnpgFs5vjRNwbefMXbG5F5eFRtPIzv5WI6rZK/7tkzfJ82zN49hDt9+492eeM28ohmTdKtm2j7cw1A1B+/C6mnigFTdQiYmc7yNNYDSCcWF0GzbB5yjTfHcWB/eAwKNVOb8hQVt5uNVfoq51FBaeCH5xKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6oqnPBo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6oqnPBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760080894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoN0dpJjGxiZ0wQf4DNv5iwB6nIANTg2G+mNbipfa0o=;
	b=J6oqnPBo2uogreN8gvBg6AnybQTvH7sCsPQVfGfT8d/gICi2o47ch8QOZD1GXrzNQw27lk
	Ad2w0TQ8IVw8v91u6Dl2LR+GEorKD/8Yrn6gXTQ5K5F4VMM82cHSkKRD+77P63q58UFMKV
	5RPraqaETuFszKAf6iloinexvMdgrpg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-JwBDf-lFPPCEobEWiiaOIw-1; Fri, 10 Oct 2025 03:21:31 -0400
X-MC-Unique: JwBDf-lFPPCEobEWiiaOIw-1
X-Mimecast-MFC-AGG-ID: JwBDf-lFPPCEobEWiiaOIw_1760080890
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afe81959e5cso188259366b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080890; x=1760685690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoN0dpJjGxiZ0wQf4DNv5iwB6nIANTg2G+mNbipfa0o=;
        b=gycgkpXOzePkq/ULRb3zyJUgwJPxx0lYp0K95je2kV1H0WLFDBS3BaZ/PSXAMf0kCS
         BdSzWnMimB6c976jb2Z8xrvLMsFjOYxyFsAoP81cRDk3cCl273Spvm+rnp8vjWyAz9Ac
         32eFfjd4nGgoncWSS1VSdQa6PXgeofcZdUyY6klZA5p6CmcpwDBDKYkwXjSpBxKEIKdb
         lVSx3cDz3vWcHm939/E7AGU52vDBMdrhrQl/rtCWB6d/KFjcnWfiOwUofooAWghlASYP
         9RkBSRt8IFVs7XdUOitU6XOp9bxa6tAn4KFihPgs2rCmbHba5My4ZEPjSo8xhFwPcBUW
         stOg==
X-Forwarded-Encrypted: i=1; AJvYcCWO8TP8xfnTvGSlNqbn699bE0oXmLHVXxQNQYITOaZPS7T9eE9wGC45tdn+d/4n/QcXsARPgovPp8Qmo+87xvl82h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNeIF0HvMFJuEd65pkfqMtu8QU+uEyIPhcPghk/e7tPql15np
	6JniJNY65BmksKrPrP8fY/+/HzxWMsmoIabge1lquDN2o/RpbVmsZuY+SUR3xnp0J1OAEefPWBp
	Gi0Z28YTBwE9M0JgS5vgXlPn1Anj/tWxUwsbxcJwmQipXHLiSxdq+uymNCodmEFHx3REEQxP3pd
	yXc8U7NSgycuN7TtKbUjphU2lr4JgGrt6e4gM6yQ9EvYkqLRF7
X-Gm-Gg: ASbGncu49E/6+7e68KchGdv08Qtz7Not6jSDKl7Mv+Z+PKy8u8tBlQ+CWRJrZmejcEW
	FlZGZgoJcmhCzQDDAgAqov9OpcdQXSfjgfuVzqP+XzXUSslBPpfu3XpQoVUf5mBtdRIbiRRjh8t
	+wcQwKIc4dMmrGd1903ZJKWjZ5AfhOZVJfWGET5TGZS7De9fYgEYCdHu4=
X-Received: by 2002:a17:907:d0d:b0:b46:6718:3f29 with SMTP id a640c23a62f3a-b50a9d6facemr1103280166b.3.1760080889817;
        Fri, 10 Oct 2025 00:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtxGrbv0D1tCUVxtHfdMD5J4fwcx28uznIcAJssW+Z5+SL/t71bkFpdvjGgLGlUSDvq+NWmofNFYne2QiySXY=
X-Received: by 2002:a17:907:d0d:b0:b46:6718:3f29 with SMTP id
 a640c23a62f3a-b50a9d6facemr1103277466b.3.1760080889404; Fri, 10 Oct 2025
 00:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008195905.333514-1-costa.shul@redhat.com>
 <20251008195905.333514-2-costa.shul@redhat.com> <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
In-Reply-To: <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 10 Oct 2025 10:20:53 +0300
X-Gm-Features: AS18NWDd9gdjeL-7ac1kmmdkaQjxIh8CkWqVuO7GoExI0sLzGguXDNu6X50mDgE
Message-ID: <CADDUTFwFerzjRTPp1F+Rw+_U2DoomAxyDonXudCwh9gyXSn=nw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error handling pattern
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Jan Stancek <jstancek@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mBtTSdIOMqx5gqM1ouGb7ZOas_eZoQZHbK-W_4fGQWY_1760080890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 00:55, Crystal Wood <crwood@redhat.com> wrote:
> Looks like there was existing inconsistency with newlines... maybe have
> fatal() include the newline automatically to simplify callers slightly?
> We're not going to print a continuation if we're exiting.
>
> Otherwise, for the whole series:
> Reviewed-by: Crystal Wood <crwood@redhat.com>

fatal() belongs to the same family as debug_msg() and err_msg().
Historically, the prototype and usage of these functions is identical
to printf().
printk() was identical as well, but now it adds a missing end-of-line
automatically.
fatal(), along with debug_msg() and err_msg(),
can be upgraded too, but they should be updated together for consistency.

Thanks
Costa

