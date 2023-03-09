Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B95C61DA4
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  9 Mar 2023 14:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCIO1G (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCIO1F (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:27:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE45D533
        for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:27:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so2068064wrw.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678372022;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf2ahHvlY2IXDyPqkpKQ3Qkug7WIJL4NOmqcaxPWKDU=;
        b=kLlzRKcT5oBqOTgDK4o8pGWZYXEXmt5ACRWZMdKjOFd6OU4GQQCOcQ133umUxkg3EH
         ZO68HPGys5S1MZ2LiZ9LpaHfoKZC+nY3fJqQ49YwKzgupO42drFAGjxv1CzIyB9CGXWy
         FA34Vfp6RJH6csoRNO6lCEdA1nokEWHGyDUI5Gwa1ajiziDz2883KBrkpQX6/+pIgI5b
         m8f21jPl1sfSPtJsxjw3sT/s8/sy8gfbghUJBPoAlroFWy1sDmMJhv7J3DQSo6WiptN0
         tTjAb7/eoJuog16hilQ1EqnJyvZkwTamfRngzObLcysSyBuB74uD3utgwG1LPKpMJGq2
         Mlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372022;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf2ahHvlY2IXDyPqkpKQ3Qkug7WIJL4NOmqcaxPWKDU=;
        b=tIN7o+fIigiVpMIK55KN3k1PYfilWBH7RqiNjPLr8STju7fJM3i2y6IhbZvbCRYhiB
         D3yau7k32ve4ss/uxiz9TAAJAoX1kHNWXI+Up6lj+lPMX1ewcODL65cCV0G2c4OppiCh
         5CIBf66v8B1H90Urw0JpNH+7D/dhGd2uxftFbBx3UavPbkQQaKU5lm47AZXSjtYYu1FT
         3U9r3j0AisdGS6S4PKzXrT1gIGcz+L9MT3bGGSwQEMmZd+dNaCVYWZzVeMyjzQHQtvXp
         rFofhCdwuaTOjJ/kz/74D/tVuSIsFPE7K/shbd6Zsl05zTF1cknx09NLifgU0GdlmX+h
         dHnQ==
X-Gm-Message-State: AO0yUKUWyyzlWfURU8B0w/k4kl3b+7e5LNxuCzExUl728fBuEZzaf20J
        YGkKzL2nnP/HcPeb17xtpAQJObJOczA=
X-Google-Smtp-Source: AK7set+w9UWRJaEQJn+3FcWkq258tqxzIBcdtEiQIGvHP88SosbXRgLzfUrDjzM0/RUijsK5LIH33A==
X-Received: by 2002:a05:6000:10d0:b0:2c7:1b4d:935f with SMTP id b16-20020a05600010d000b002c71b4d935fmr2161391wrx.0.1678372022024;
        Thu, 09 Mar 2023 06:27:02 -0800 (PST)
Received: from DESKTOP-8VK398V ([125.62.90.127])
        by smtp.gmail.com with ESMTPSA id j17-20020adff011000000b002c5a1bd527dsm17872625wro.96.2023.03.09.06.27.01
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 09 Mar 2023 06:27:01 -0800 (PST)
Message-ID: <6409ecb5.df0a0220.ecd43.c8ff@mx.google.com>
Date:   Thu, 09 Mar 2023 06:27:01 -0800 (PST)
X-Google-Original-Date: 9 Mar 2023 19:27:01 +0500
From:   krewkaydenr843@gmail.com
X-Google-Original-From: KrewKaydenr843@gmail.com
MIME-Version: 1.0
To:     linux-trace-kernel@vger.kernel.org
Subject: Estimate To Bid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,=0D=0A=0D=0ACrown Estimation, LLC is experts in providing cost=
ing and takeoff solutions to GC's and Sub's. We are based in NJ. =
We do estimate all types of construction projects including resid=
ential, commercial, new build and federal government projects.=0D=0A=
=0D=0Aplease send me the plans if you have any job for a quote on=
 our service charges before getting started.=0D=0A=0D=0AYou may a=
sk for any type of samples.Thanks.=0D=0A=0D=0ABest Regards,=0D=0A=
Krew Kaydenr=0D=0AMarketing Manager=0D=0ACrown Estimation, LLC=0D=0A

