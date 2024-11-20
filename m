Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD83804
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732079063; cv=none; b=iail0Cw/c8lbuT6bK+PFtgHnhIjU3BAA2uG+9rz61B/SFMHJ/+ozCUtSm0/lYxnCeU/NqORPDWo9yPFStlPHN+hC4j+kLejA4KTWV9wHyThEKsOrx1YKpzg6uxz5cWLoUQqcVQ0cpdAE6X8KfK92MGkk2DVreWiZg+ZKQaGW1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732079063; c=relaxed/simple;
	bh=vDAqi2dqCWiN2YZnhNhVTCZw5+wN6pHMmpmkkkjKH1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVkZ8A0PYWE/jOc9l5co0HcoYlQzW5w9w8J9vkywQ4AVNYbR+Uj3hTlk4LNis/2U61RnpPRm2kkDR2utk/aK1cUeDPScAxBwYtLGzhLUJCN7Gc1uIhShs+mLCFxI65ALL4lV9N9XQPe73xhTbv2ooQj01vNjLCo0XKPRlWnQ3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cc6N2m0B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc6N2m0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732079060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDAqi2dqCWiN2YZnhNhVTCZw5+wN6pHMmpmkkkjKH1Q=;
	b=cc6N2m0BSyJYcoHw9DCxd2Zr9bb+dcdY5R3DiAf2xATciz7QoiX56a15AEmpgGpO6BffHn
	XNjzghMaIsC/ELyDZBrOjVcQ77FJ5JCTT49XvzxRgOI7iQkNka/JqmSghsGfjAad1ldfsa
	67nTG9wANMd9Aw0yXyz5rBrX7lm26UE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-3EHu0Q4YPNqNOkhsBfkC5A-1; Wed, 20 Nov 2024 00:04:18 -0500
X-MC-Unique: 3EHu0Q4YPNqNOkhsBfkC5A-1
X-Mimecast-MFC-AGG-ID: 3EHu0Q4YPNqNOkhsBfkC5A
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso255779866b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732079057; x=1732683857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDAqi2dqCWiN2YZnhNhVTCZw5+wN6pHMmpmkkkjKH1Q=;
        b=YwVitej7pFXmJKAb2/sFBfdkPwNR846sZn9T93bWvdQtNM0+D38REfCQ455+ALOZw1
         k5CZJRZK9DmhCb52x1R5Q+Ntar9BAM0EGmr6sPpKhSyMRs7/rPRNbad10nOhTB4DJ2Vb
         dyifSPVp4OK2F5gFdnR4JXJu6UFFwAyfVU8b5vO7kN1ugafzjQJxK/tEPlFNO4PdjjcE
         vpABNGE27BhZjo51kW8gpENjMtQf6KZKMp+sxh45UJ57Cd7w4QW8y8BC4uX23z59mf5Y
         HmtfSHDYmWCFjPez5aYRaUl3CIFM8gVHxwQitvpAnb9uaE3DaQjyN8H9hiSpsM54Gm9S
         RfNA==
X-Gm-Message-State: AOJu0YxQoBDazYQaSkXLy7ixWEZ2SJqcmkc9HsDNEpjG7ejfpkKlHse2
	CVuIkxn2xSRjCeiYR14V3cBOjGpK57FEG2pOZuZvfpPSL8S5w57OM5nJBtbrFkCeecwudWi0NeO
	wyKwXQuVK9imrOfKD3hGLxtE1GfvZKVcPK+FNf6XdMl+WB4pYxh5/5+1uCSBOiqKM7DM9MMlANw
	PRWjS2wEz3UuZvVzzLw4Gtouqe2xge3Kl2UBS7gC9+dUuU
X-Received: by 2002:a17:907:d24:b0:a9a:dfa5:47d2 with SMTP id a640c23a62f3a-aa4dd766b0cmr115553066b.59.1732079057057;
        Tue, 19 Nov 2024 21:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJqqbJngHMM5ArDt8/GXCWAKULtZ8n7hwb8ar5N+ZdcEu0iuznBUyULwAgVQGAf1ye5qTvujjwqCL1l80JPqM=
X-Received: by 2002:a17:907:d24:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-aa4dd766b0cmr115552066b.59.1732079056738; Tue, 19 Nov 2024
 21:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119134858.1862632-1-tglozar@redhat.com> <20241119102257.3df588ce@gandalf.local.home>
In-Reply-To: <20241119102257.3df588ce@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 20 Nov 2024 06:04:05 +0100
Message-ID: <CAP4=nvQ-J9uEm-mAnBhjLvy_LOzB4KvMoCBYeeo4w5_fMwbiow@mail.gmail.com>
Subject: Re: [PATCH] rtla/timerlat: Fix histogram ALL for zero samples
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -UJm42_-pccCEm-56dyku3Gy-AMTLXHcYz9RXwkCSN8_1732079057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 19. 11. 2024 v 16:22 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
>
> There's a lot of duplicate code here. Can you please make a helper
> function, that at least has:

Good point, I thought it's not that bad when I was writing it, but
together with the already implemented ifs, this pattern is now there
19 times. I will send a v2 once I'm back from vacation.

Tomas

